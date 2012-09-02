#!/bin/bash

cd /var/www/gamehub/node
nohup node-supervisor Main.js > output.log &