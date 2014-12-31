#!/usr/bin/env bash
# A simple script that downloads all blacklists in the list, and saves them in one mega-list
# Written by: Adam Walsh
# Written on 2/24/14

#This has been tested on Ubuntu 12.04

#-----CONFIG-----
LIST="list.txt"     #This is the name of the final list file

while getopts ":c:zh" opt; do
	case $opt in
		c)
			CONF_DIR=$OPTARG
			;;
		z)
			zip=true
			;;
			
		h)
      			echo -ne "Usage: -c config dir\n\t-z gzip result file ( doesn't work with daemon 2.84 )\n"
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

elif [[ $OSTYPE =~ "darwin" ]]; then
	path_to_config=$HOME/Library/Application\ Support/Transmission

else
	path_to_config=$HOME/.config/transmission
fi

blocklist_path=$path_to_config/blocklists

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
#---END CONFIG---

if tty -s; then
	info() {
		echo "$@"
	}
else # we're non-interactive, no output needed
	info() {
		true
	}
fi

die() {
	echo "$@"
	exit 1
}

rm -f $LIST #delete the old list

if wget=$(command -v wget); then
	download() { 
		$wget -q -O "list.gz" "$1"
	}
elif curl=$(command -v curl); then
	download() { 
		$curl "$1" -L -o "list.gz"
	}
else
	die "$0: 'wget' or 'curl' required but not found. Aborting."
fi

index=0
for url in "${URLs[@]}"; do
        title="${TITLEs[$index]}"
	    info "Downloading list $title"
	    download "$url" || die "Cannot download from $url"
	    info "Adding IP's to list file..."
	    gunzip -c "list.gz" >> "$LIST"  || die "Cannot append to list" #append to list file
	    rm "list.gz" || die "Cannot remove downloaded file"
	    info ""
        index=$((index+=1))
done

if [[ ! -z $zip ]]; then
	info "Zipping..."
	gzip -c $LIST > list.gz || die "Cannot gzip"
	info "Copying zipped list to $blocklist_path"
	cp list.gz "$blocklist_path/" || die "Cannot copy to $blocklist_path/"
else
	info "Copying list to $blocklist_path"
	cp list.txt "$blocklist_path/" || die "Cannot copy to $blocklist_path/"
fi

wc -l $LIST || die "Cannot count lines" #print out some list stats
rm -f list.* || die "Cannot cleanup"

info "Done!"
info "Restart transmission"
