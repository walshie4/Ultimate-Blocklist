Ultimate-Blocklist
==================

A super blocklist made from the most popular ones on the web!

###Reqs:

* `Python 2.7.8`

###Note:
When using the BitTorrent protocol using blocklists does *nothing*! If you are a part of the swarm of ip's
yours can be logged, neither this nor any other IP block software can protect you from that. Read more [here](http://www.reddit.com/r/torrents/comments/17gold).

##How to: (Docker Version)

```
docker build -t ubl .
docker run -it --name ubl ubl
docker cp ubl:/usr/src/app/blocklist.txt .
```

or

```
make docker
```

##How to: (Python Version)

* Download latest release
* (optional) Create a virtual environment ``virtualenv --no-site-packages env``
* (optional) Activate the virtual environment ``source env/bin/activate``
* Install the dependencies ``pip install -r requirements.pip``
* Run `python UltimateBlockList.py`
* Wait and your blocklist will be available in `blocklist.txt` when the script exits

##How to use: (Shell-Script Verison)

 * <b>Generate a local brand-new list</b>
     * Run using `./UpdateList.sh`
     * `-c path_to_transmission_conf_dir` (if you use your system's default location, this option is unnecessary)
     * `-z` flag will create gzipped file ( transmission daemon 2.84 won't load gzipped file properly )
     * Note: You can find your config directory [here](https://trac.transmissionbt.com/wiki/ConfigFiles)
     * Your blocklist will be loaded the next time you start Transmission
 * <b>Use a pre-generated list</b>
     * The list is hosted and available [here](https://gist.github.com/walshie4/6648a23223db413d3b15).
       Unfortunately the file is so large that gist can't even show the whole thing properly. So you'll have to download
       it and move it in to position manually. (see above note)
        * Updated 12/7/2014
 * <b>Setup on a webserver</b>
     * Upload the folder content (or clone this repo) to your webserver
     * Make sure the permission are right (755) for the scripts
     * Add to your crontab
     		Daily: 00 00 * * * ./UpdateList.sh
     * Make your Torrent app point to your webserver like so: http://myserver.com/list.txt to download the newly generated list

Special thanks to [alphapapa](https://github.com/alphapapa) for the idea behind the design of the new script.
