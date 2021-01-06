<a href="https://www.buymeacoffee.com/medheeraj"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a beer&emoji=🍺&slug=medheeraj&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff"></a>

Last updated on 2020/12/29

## Introduction

**Lilly**
Tool to find the real IP behind CDNs/WAFs like cloudflare using passive recon by retrieving the favicon hash. For the same hash value, all the possible IPs, PORTs and SSL/TLS Certs are searched to validate the target in-scope.

## Usage
```
root@me_dheeraj:$ bash lilly.sh
[-] Argument: -d/--domain target.com -a/--api Required

       Usage: ./lilly.sh -d/--domain target.com -a/--api premium_api

Output will be saved in output/target.com-YYYY-MM-DD directory
```
##### Prerequisites
- python3 
- jq
- pip3 install shodan
- pip3 install mmh3
- Shodan Member Account & API
- httpx [@pdiscoveryio](https://github.com/projectdiscovery/httpx)
- Multi-Threading interlace - [@codingo](https://github.com/codingo/Interlace)


## Tool of the week
https://blog.intigriti.com/2021/01/06/bug-bytes-104-cache-poisoning-dos-burp-themes-a-couple-of-facebook-account-takeovers/
