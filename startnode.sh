#!/bin/bash

cd /var/www/gamehub/node
nohup node Main.js > output.log &
#node-supervisor Main.js &
