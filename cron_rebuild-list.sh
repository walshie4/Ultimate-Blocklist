#!/usr/bin/env bash
# A simple script that will delete the existing files and rerun the buildà
#
# Add to your cron like so:
#
# 00 00 * * * ./cron_rebuild-list.sh
#
# Written by: Alexandre Vallières-Lagacé
# Written on 2014/03/04

rm -R list.gz list.txt
./UpdateList.sh

echo "Completed!"
