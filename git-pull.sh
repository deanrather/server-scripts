#!/bin/bash

# Check that a parameter was passed in
if [ "$1" = "" ]
then
        echo -e "you must pass in the path to the git repo"
        exit 1
fi

echo -e "changing working directory to $1";
cd $1 || exit

echo -e "unsetting git dir"
unset GIT_DIR

echo -e "updating from origin"
git pull origin master
