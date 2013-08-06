#!/bin/bash

# Check that the script is being run as sudo
if [ "$(id -u)" != "0" ]
then
   echo "This script must be run as root" 1>&2
   exit 1
fi

service bind9 restart
