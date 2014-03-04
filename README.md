Ultimate-Blocklist
==================

A super blocklist made from the most popular ones on the web!

<b>How to use:</b>

 * <b>Generate a local brand-new list</b>
     * Run using `./UpdateList.sh`
     * Move the `lists.txt` file to the `/blocklists/` directory
     * Note: You can find your `/blocklists/` directory [here](https://trac.transmissionbt.com/wiki/ConfigFiles)
 * <b>Use a pre-generated list</b>
     * The list is hosted and available at the url `http://download847.mediafire.com/18d81fiysgvg/h6raqc326niak73/list.txt`
 * <b>Setup on a webserver</b>
     * Upload the folder content to your webserver
     * Make sure th permission are right (755) for the scripts
     * Add to your crontab
     		Daily: 00 00 * * * ./cron_rebuild-list.sh
     * Make your Torrent app point to your webserver like so: http://myserver.com/list.php to download the newly generated list

Contributor: Alexandre Vallières-Lagacé <alexandre@vallier.es>