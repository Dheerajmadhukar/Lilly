<a href="https://www.buymeacoffee.com/medheeraj"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a beer&emoji=🍺&slug=medheeraj&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff"></a>

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
##### Prerequisite
- python3
- pip3 install shodan
- Shodan Member Account & API
- httpx [https://github.com/projectdiscovery/httpx]
