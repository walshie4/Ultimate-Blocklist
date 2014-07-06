#!/usr/bin/env python
#Written for Pyhon 2.7.5
#Written by: Adam Walsh
#Written on 7/6/14
#Maintained @ https://github.com/walshie4/Ultimate-Blocklist

import requests
from bs4 import BeautifulSoup as mksoup

print("Getting list page")
soup = mksoup(requests.get("https://www.iblocklist.com/lists.php").text)
for row in soup.find_all("tr")[1:]:#for each table row
    print(list(row.children)[0])
         #   .split("\"")[1])
    break

