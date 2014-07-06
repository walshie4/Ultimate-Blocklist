#!/usr/bin/env python
#Written for Pyhon 2.7.5
#Written by: Adam Walsh
#Written on 7/6/14
#Maintained @ https://github.com/walshie4/Ultimate-Blocklist

import requests
from bs4 import BeautifulSoup as mksoup

print("Getting list page")
soup = mksoup(requests.get("https://www.iblocklist.com/lists.php").text)
links = {}#dict of name of list -> its url
for row in soup.find_all("tr")[1:]:#for each table row
    section = str(list(row.children)[0])
    pieces = section.split("\"")
    links[pieces[2].split("<")[0][1:]] = pieces[1]

print links

