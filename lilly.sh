#!/bin/bash
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
end="\e[0m"
Usage() {
       echo -e "$green
       Usage: ./lilly.sh -d/--domain target.com -a/--api premium_api
       "$end
  exit 1
}
shodan_ip() {
shodan init $shodan_api
folder=$target-$(date '-I')
mkdir -p output/$folder;cd output/$folder
echo -e ">> \e[36mSubdomain Enum\e[0m is in progress"
#CRT.SH
curl -s "https://crt.sh/?q=%25.$target&output=json"| jq -r '.[].name_value' 2>/dev/null | sed 's/\*\.//g' | sort -u | grep -o "\w.*$target" | httpx -threads 100 -silent | tee alive.txt
echo -e ">> \e[36mDONE\e[0m"
echo -e ">> \e[36mFavicon Hash\e[0m is in progress"
cat alive.txt | xargs -I %% bash -c 'echo "%%/favicon.ico"' > favicon_targets.txt
cat favicon_targets.txt | xargs -I %% bash -c "curl %% -k -s -o /dev/null -w '%% ''%{http_code}\n' -X GET | grep 200" > favicon_urls.txt;rm favicon_targets.txt
cat favicon_urls.txt | awk '{print $1}'| xargs -I %% bash -c "echo %% ; curl -s -L -k %% | python3 -c 'import mmh3,sys,codecs; print(mmh3.hash(codecs.encode(sys.stdin.buffer.read(),\"base64\")))'"> hash.txt
cat hash.txt | awk 'NR%2{printf "%s ",$0;next;}1' > favi_hash.txt;rm hash.txt -f
for hasshh in $(cat favi_hash.txt|awk '{print $2}');do shodan search http.favicon.hash:$hasshh --fields ip_str,port --separator " " | awk '{print $1 ":" $2}' > favicon_ips.txt;done
cat favicon_ips.txt | httpx -threads 500 -silent | interlace -threads 100 -c "echo _target_; curl --insecure -v _target_ 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }'" --silent | grep "https:\/\/\|CN\=\|issuer: " | tee all_certs.txt
#for cert in $(cat favicon_ips.txt);do curl --insecure -v $cert 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }' grep 'https:\/\/\|CN\=\|issuer:' | tee all_certs.txt ;done
}
target=False
shodan_api=False
list=(
        shodan_ip
)
while [ -n "$1" ]; do
                    case "$1" in
                        -d | --domain)
                        target=$2
                        shift
                        ;;
                        -a | --api)
                        shodan_api=$2
                        shift
                        ;;
                        *) echo -e $red"[-]"$end "Unknown Option: $1"
                        Usage
                        ;;
          esac
shift
done
[[ $target == "False" ]] && [[ $shodan_api == "False" ]] && {
echo -e $red"[-]"$end "Argument: -d/--domain target.com -a/--api Required"
Usage
}
(
shodan_ip
)
