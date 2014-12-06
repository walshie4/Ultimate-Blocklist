#!/usr/bin/env python
#Written for Pyhon 2.7.5
#Written by: Adam Walsh
#Written on 7/6/14
#Maintained @ https://github.com/walshie4/Ultimate-Blocklist

import requests
import urllib
from bs4 import BeautifulSoup as mksoup
import gzip

BASE = "https://www.iblocklist.com"

def get_value_from(url):
    soup = mksoup(requests.get(BASE + url).text)
    return str(soup.find_all("input")[-1]).split("\"")[-2]

def process(url):
    handle = urllib.urlopen(url)
    with open('ultBlockList.tmp.gz', 'wb') as out:
        while True:
            data = handle.read(1024)
            if len(data) == 0: break
            out.write(data)
    contents = gzip.GzipFile('ultBlockList.tmp.gz')
    f = open("blocklist.txt", "a+")#TODO add check for if it exists
    for line in contents:
        f.write(line)
    f.close()

if __name__=="__main__":
    print("Getting list page")
    soup = mksoup(requests.get("https://www.iblocklist.com/lists.php").text)
    links = {}#dict of name of list -> its url
    for row in soup.find_all("tr")[1:]:#for each table row
        section = str(list(row.children)[0])
        pieces = section.split("\"")
        links[pieces[2].split("<")[0][1:]] = pieces[1]

    for link in links:#download and combine files
        print "Downloading " + link + " blocklist."
        value = get_value_from(links[link])
        if value == "subscription":
            print "Blocklist is not available for free download D:"
        elif value == "unavailable":
            print "URL is unavailable"
        else:#download and add this sucker
            process(value)

