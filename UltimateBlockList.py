#!/usr/bin/env python
#Written for Pyhon 2.7.5
#Written by: Adam Walsh
#Written on 7/6/14
#Maintained @ https://github.com/walshie4/Ultimate-Blocklist

import requests
import urllib
from bs4 import BeautifulSoup as mksoup
import gzip
import os

token = os.getenv('DROPBOX_ACCESS_TOKEN')

if token:
    from dropbox.client import DropboxClient

    db_client = DropboxClient(token)

BASE = "https://www.iblocklist.com"

def get_value_from(url):
    soup = mksoup(requests.get(BASE + url).text)
    return str(soup.find_all("input")[-1]).split("\"")[-2]

def process(url):
    try:
        handle = urllib.urlopen(url)
    except Exception as e:
        print("URL open failed! Exception following:")
        print(e)
        return
    with open('ultBlockList.tmp.gz', 'wb') as out:
        while True:
            data = handle.read(1024)
            if len(data) == 0: break
            out.write(data)
    with gzip.open('ultBlockList.tmp.gz') as contents:
        with open("blocklist.txt", "a+") as f:
            for line in contents:
                f.write(line)
    os.remove('ultBlockList.tmp.gz')

if __name__=="__main__":
    print("Getting list page")
    soup = mksoup(requests.get("https://www.iblocklist.com/lists.php").text)
    links = {}#dict of name of list -> its url
    for row in soup.find_all("tr")[1:]:#for each table row
        section = str(list(row.children)[0])
        pieces = section.split("\"")
        links[pieces[4].split("<")[0][1:]] = pieces[3]

    for link in links:#download and combine files
        print "Downloading " + link + " blocklist."
        value = get_value_from(links[link])
        if value == "subscription":
            print "Blocklist is not available for free download D:"
        elif value == "unavailable":
            print "URL is unavailable"
        else:#download and add this sucker
            process(value)

    if token:
        file = open('blocklist.txt', 'rb')
        response = db_client.put_file('/blocklist.txt', file, overwrite=True)

        print 'Uploaded to Dropbox!'
