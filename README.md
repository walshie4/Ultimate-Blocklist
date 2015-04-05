Ultimate-Blocklist
==================

A super blocklist made from the most popular ones on the web!

###Reqs:

* `Python 2.7.8`

###Note:
When using the BitTorrent protocol using blocklists does *nothing*! If you are a part of the swarm of ip's
yours can be logged, neither this nor any other IP block software can protect you from that. Read more [here](http://www.reddit.com/r/torrents/comments/17gold).

##Docker Version

```
docker build -t ubl .
docker run -it --name ubl ubl
docker cp ubl:/usr/src/app/blocklist.txt .
```

or

```
make docker
```

##Python Version

* Download latest release
* (optional) Create a virtual environment ``virtualenv --no-site-packages env``
* (optional) Activate the virtual environment ``source env/bin/activate``
* Install the dependencies ``pip install -r requirements.pip``
* Run `python UltimateBlockList.py`
* Wait and your blocklist will be available in `blocklist.txt` when the script exits

##Shell Verison

 * *Generate a local brand-new list*
     * Run using `./UpdateList.sh`
     * `-c path_to_transmission_conf_dir` (if you use your system's default location, this option is unnecessary)
     * `-z` flag will create gzipped file ( transmission daemon 2.84 won't load gzipped file properly )
     * Note: You can find your config directory [here](https://trac.transmissionbt.com/wiki/ConfigFiles)
     * Your blocklist will be loaded the next time you start Transmission
 * *Use a pre-generated list*
     * The list is hosted and available [here](https://www.dropbox.com/s/2f8irg93zgglh2d/blocklist.txt?dl=1).
 * *Setup on a webserver*
     * Upload the folder content (or clone this repo) to your webserver
     * Make sure the permission are right (755) for the scripts
     * Add to your crontab
     		Daily: 00 00 * * * ./UpdateList.sh
     * Make your Torrent app point to your webserver like so: http://myserver.com/list.txt to download the newly generated list

Special thanks to [alphapapa](https://github.com/alphapapa) for the idea behind the design of the new script.


##Dropbox Version

* *Build with [Docker](#dropbox-version)*

* Setup a cron job to run the script using docker and upload to Dropbox
using the environment variable `DROPBOX_ACCESS_TOKEN`.
    * Ex. `0 5 * * * /usr/bin/docker run --rm -it -e DROPBOX_ACCESS_TOKEN="..." ubl`

Thanks to [voxxit](//github.com/voxxit) for helping add this feature

---

##Contributors

Please check [here](//github.com/walshie4/Ultimate-Blocklist/graphs/contributors) for a full list of contributors.

