#!/usr/bin/env bash
# A simple script that downloads all blacklists in the list, and saves them in one mega-list
# Written by: Adam Walsh
# Written on 2/24/14

#This has been tested on Ubuntu 12.04

#-----CONFIG-----
LIST="list.txt"     #This is the name of the final list file
PATH_TO_LIST="~/"   #This is the path to the final list file
#---END CONFIG---
declare -a TITLEs=("Bluetack LVL 1" "Bluetack LVL 2" "Bluetack LVL 3" "Bluetack edu" "Bluetack ads"
        "Bluetack spyware" "Bluetack proxy" "Bluetack badpeers" "Bluetack Microsoft" "Bluetack spider"
        "Bluetack hijacked" "Bluetac dshield" "Bluetack forumspam" "Bluetack webexploit" "TBG Primary Threats"
        "TBG General Corporate Range" "TBG Buissness ISPs" "TBG Educational Institutions"
        )
declare -a URLs=("http://list.iblocklist.com/?list=bt_level1&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_level2&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_level3&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_edu&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_ads&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_spyware&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_proxy&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_templist&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_microsoft&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_spider&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_hijacked&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=bt_dshield&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=ficutxiwawokxlcyoeye&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=ghlzqtqxnzctvvajwwag&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=ijfqtofzixtwayqovmxn&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=ecqbsykllnadihkdirsh&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=jcjfaxgyyshvdbceroxf&fileformat=p2p&archiveformat=gz"
            "http://list.iblocklist.com/?list=lljggjrpmefcwqknpalp&fileformat=p2p&archiveformat=gz"
            )

if [[ -f "$LIST" ]]; then #if output file exists
    echo "The output file '$LIST' already exists! Please rename or move this file."
    exit 1
fi
touch "$LIST" #touch resulting file
declare -i index=0
for url in "${URLs[@]}"; do #For each url
    echo "Now downloading list ${TITLEs[$index]}"
    curl "$url" -L -o "list.gz"            #download the zipped version
    echo "Unzipping..."
    gunzip "list.gz"       #unarchive the list
    echo "Adding IP's to list file..."
    cat "list" >> "$LIST"  #append to list file
    echo "Deleting downloaded list file..."
    rm "list"                           #Delete downloaded list file
    echo
    index=$((index+=1))
done
wc $LIST #print out some list stats
echo "Done!"
