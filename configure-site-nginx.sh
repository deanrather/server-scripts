#!/bin/bash

echo -e "setting up $1 in nginx"

echo -e "making the folder"
DIRECTORY="/var/www/$1/public"
mkdir -p $DIRECTORY

echo -e "making a test index.php"
echo "$1 is currently under maintenance" > "$DIRECTORY/index.php"

echo -e "creating the config file"
cd /etc/nginx/sites-available/
sed "s/DOMAIN/$1/" <template >$1

echo -e "linking the config file"
cd /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/$1

echo -e "restarting nginx"
service nginx restart
