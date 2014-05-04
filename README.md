Ultimate-Blocklist
==================

A super blocklist made from the most popular ones on the web!

###Note:
When using the BitTorrent protocol using blocklists does *nothing*! If you are a part of the swarm of ip's
yours can be logged, neither this nor any other IP block software can protect you from that. Read more [here](http://www.reddit.com/r/torrents/comments/17gold).

##How to use:

 * <b>Generate a local brand-new list</b>
     * Run using `./UpdateList.sh`
     * Move the `lists.txt` file to the `/blocklists/` directory
     * Note: You can find your `/blocklists/` directory [here](https://trac.transmissionbt.com/wiki/ConfigFiles)
     * Your blocklist will be loaded the next time you start Transmission
 * <b>Use a pre-generated list</b>
     * The list is hosted and available at the url `http://download1979.mediafire.com/ocqugqyet8kg/ep841wv4aef2zwd/list.txt`
        * Updated 3/16/2014
 * <b>Setup on a webserver</b>
     * Upload the folder content (or clone this repo) to your webserver
     * Make sure the permission are right (755) for the scripts
     * Add to your crontab
     		Daily: 00 00 * * * ./UpdateList.sh (or ./UpdateListOSX.sh if on a OSX machine)
     * Make your Torrent app point to your webserver like so: http://myserver.com/list.txt to download the newly generated list

Orignal Author: Adam Walsh <adw7422@rit.edu>

Contributor: Alexandre Vallières-Lagacé <alexandre@vallier.es>
