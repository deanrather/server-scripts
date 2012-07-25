#!/bin/bash

# Check that the script is being run as sudo
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "the script is running!"


# Check whether the string exists in the file
if grep -Fq "banana" test.txt
then
	echo "banana is"
else
	echo "banana isn't"
fi
