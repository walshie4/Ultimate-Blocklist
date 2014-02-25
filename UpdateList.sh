#!/usr/bin/env bash
# A simple script that downloads all blacklists in the list, and saves them in one mega-list
# Written by: Adam Walsh
# Written on 2/24/14

#This has been tested on Ubuntu 12.04

#-----CONFIG-----
LIST="list.txt"     #This is the name of the final list file
PATH_TO_LIST="~/"   #This is the path to the final list file
#---END CONFIG---

declare -a URLs=("http://list.iblocklist.com/?list=bt_level1&fileformat=p2p&archiveformat=gz"  #Bluetack LVL 1
            "http://list.iblocklist.com/?list=bt_level2&fileformat=p2p&archiveformat=gz"       #Bluetack LVL 2
            "http://list.iblocklist.com/?list=bt_level3&fileformat=p2p&archiveformat=gz"       #Bluetack LVL 3
            "http://list.iblocklist.com/?list=bt_edu&fileformat=p2p&archiveformat=gz"          #Bluetack edu
            "http://list.iblocklist.com/?list=bt_ads&fileformat=p2p&archiveformat=gz"          #Bluetack ads
            "http://list.iblocklist.com/?list=bt_spyware&fileformat=p2p&archiveformat=gz"      #Bluetack spyware
            "http://list.iblocklist.com/?list=bt_proxy&fileformat=p2p&archiveformat=gz"        #Bluetack proxy
            "http://list.iblocklist.com/?list=bt_templist&fileformat=p2p&archiveformat=gz"     #Bluetack badpeers
            "http://list.iblocklist.com/?list=bt_microsoft&fileformat=p2p&archiveformat=gz"    #Bluetack Microsoft
            "http://list.iblocklist.com/?list=bt_spider&fileformat=p2p&archiveformat=gz"       #Bluetack spider
            "http://list.iblocklist.com/?list=bt_hijacked&fileformat=p2p&archiveformat=gz"     #Bluetack hijacked
            "http://list.iblocklist.com/?list=bt_dshield&fileformat=p2p&archiveformat=gz"      #Bluetack dshield
            "http://list.iblocklist.com/?list=ficutxiwawokxlcyoeye&fileformat=p2p&archiveformat=gz"#Bluetack forumspam
            "http://list.iblocklist.com/?list=ghlzqtqxnzctvvajwwag&fileformat=p2p&archiveformat=gz"#Bluetack webexploit
            "http://list.iblocklist.com/?list=ijfqtofzixtwayqovmxn&fileformat=p2p&archiveformat=gz"#TBG Primary Threats
            "http://list.iblocklist.com/?list=ecqbsykllnadihkdirsh&fileformat=p2p&archiveformat=gz"#General corporate ranges
            "http://list.iblocklist.com/?list=jcjfaxgyyshvdbceroxf&fileformat=p2p&archiveformat=gz"#Buissness ISPs
            "http://list.iblocklist.com/?list=lljggjrpmefcwqknpalp&fileformat=p2p&archiveformat=gz"#Educational Institutions
)

touch "$LIST" #touch resulting file

for url in "${URLs[@]}"; do #For each url
    echo "Now downloading list @ $url"
    wget -O "list.gz" "$url"            #download the zipped version
    echo "Unzipping..."
    gunzip "list.gz"       #unarchive the list
    echo "Adding IP's to list file..."
    cat "list" >> "$LIST"  #append to list file
    echo "Deleting downloaded list file..."
    rm "list"                           #Delete downloaded list file
done
echo "Done!"
