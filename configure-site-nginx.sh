#!/bin/bash

# Check that the script is being run as sudo
if [ "$(id -u)" != "0" ]
then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Check that the domain was passed in
if [ "$1" = "" ]
then
        echo -e "you must pass in the domain name as parameter 1"
        exit 1
fi

echo -e "setting up $1 in nginx"

echo -e "making the folder"
DIRECTORY="/var/www/$1/public"
mkdir -p $DIRECTORY

echo -e "making a test index.php"
echo "$1 is currently under maintenance" > "$DIRECTORY/index.php"

echo -e "creating the config file"
cat <<EOF >/etc/nginx/sites-available/$1
server {
    listen 80;
    server_name $1;
    root /var/www/$1/public;
    error_log /var/log/nginx/$1-error.log;

    try_files \$uri \$uri/ /index.php?\$uri&\$args;
    expires max;

    include common.conf;
    include php.conf;
}

server {
    listen 80;
    server_name www.$1;
    rewrite ^ http://$1\$uri permanent;
}
EOF

echo -e "linking the config file"
cd /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/$1

echo -e "restarting nginx"
service nginx restart
