#!/usr/bin/env bash
# A simple script that downloads all blacklists in the list, and saves them in one mega-list
# Written by: Adam Walsh
# Written on 2/24/14

#This has been tested on Ubuntu 12.04

#-----CONFIG-----
LIST="list.txt"     #This is the name of the final list file

while getopts ":c:h" opt; do
	case $opt in
		c)
			CONF_DIR=$OPTARG
			;;
		h)
      			echo "Usage: -c config dir"
      			exit 0
      			;;
		\?)
    			echo "Invalid option: -$OPTARG" >&2
    			exit 1
    			;;
    		:)
      			echo "Option -$OPTARG requires an argument." >&2
      			exit 1
      			;;
	esac
done

if [[ ! -z $CONF_DIR ]]; then
	path_to_config=$CONF_DIR
else
	if [[ $OSTYPE == "linux-gnu" ]]; then
		path_to_config=$HOME/.config/transmission
	else # we're on a Mac!
		path_to_config=$HOME/Library/Application\ Support/Transmission
	fi
fi

blocklist_path=$path_to_config/blocklists

#---END CONFIG---

TITLEs=("Bluetack LVL 1" "Bluetack LVL 2" "Bluetack LVL 3" "Bluetack edu" "Bluetack ads"
        "Bluetack spyware" "Bluetack proxy" "Bluetack badpeers" "Bluetack Microsoft" "Bluetack spider"
        "Bluetack hijacked" "Bluetack dshield" "Bluetack forumspam" "Bluetack webexploit" "TBG Primary Threats"
        "TBG General Corporate Range" "TBG Buissness ISPs" "TBG Educational Institutions"
        )
URLs=("http://list.iblocklist.com/?list=bt_level1&fileformat=p2p&archiveformat=gz"
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

rm -f $LIST #delete the old list

if wget=$(command -v wget); then
	function download_zipped_version() { $wget -q -O "list.gz" "$1"; }
elif curl=$(command -v curl); then
	function download_zipped_version() { $curl "$1" -L -o "list.gz"; }
else
	echo "$0: 'wget' or 'curl' required but not found. Aborting."
	exit 1
fi

index=0
for url in "${URLs[@]}"; do #For each url
    echo "Now downloading list ${TITLEs[$index]}"
    download_zipped_version $url
    echo "Unzipping..."
    gunzip "list.gz"       #unarchive the list
    echo "Adding IP's to list file..."
    cat "list" >> "$LIST"  #append to list file
    echo "Deleting downloaded list file..."
    rm "list"                           #Delete downloaded list file
    echo
    index=$((index+=1))
done
echo "Zipping..."
gzip -c $LIST > list.gz || exit 1
wc $LIST || exit 1 #print out some list stats

echo "Copying list to default blocklist directory..."
cp list.gz "$blocklist_path/" || exit 1
rm -f list.* || exit 1

echo "Done!"
