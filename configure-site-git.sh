#!/bin/bash

# Check that the domain was passed in
if [ "$1" = "" ]
then
        echo -e "you must pass in the domain name as parameter 1"
        exit 1
fi

echo -e "setting up $1 git"


# Create the bare repo
echo -e "making the folder"
DIRECTORY="/home/ubuntu/git/$1/"
mkdir -p $DIRECTORY

echo -e "changing working directory to $DIRECTORY";
cd $DIRECTORY || exit

echo -e "unsetting git dir"
unset GIT_DIR

echo -e "creating bare git repo"
git init --bare


# Create the production repo
DIRECTORY2="/var/www/$1"
echo -e "changing working directory to $DIRECTORY2";
cd $DIRECTORY || exit

echo -e "unsetting git dir"
unset GIT_DIR

echo -e "initing git repo"
git init

echo -e "setting remote origin"
git set remote origin $DIRECTORY


# Setup the post-receive hook
echo -e "setting upo the post-receive hook"
echo "/home/ubuntu/scripts/git-pull.sh $DIRECTORY2" > "$DIRECTORY/hooks/post-receive"

