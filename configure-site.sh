#!/bin/bash

# Check that the domain was passed in
if [ "$1" = "" ]
then
        echo -e "you must pass in the domain name as parameter 1"
        exit 1
fi

echo -e "setting up nginx, dns, git for $1"

/home/ubuntu/scripts/configure-site-nginx.sh $1
/home/ubuntu/scripts/configure-site-dns.sh $1
/home/ubuntu/scripts/configure-site-git.sh $1

echo -e "done"
