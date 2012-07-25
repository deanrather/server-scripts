#!/bin/bash -e
# -e means exit if any command fails
DBHOST=localhost
DBUSER=root
DBPASS=dev
DBNAME=gamehub
GITREPO=/home/ubuntu/git/gamehub-db
cd $GITREPO

echo "dumping $DBNAME"
mysqldump -h $DBHOST -u $DBUSER -p$DBPASS $DBNAME --lock-tables=false --skip-comments  > $GITREPO/dbase.sql


if
         [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]
then
	echo "git-adding and committing"
	git add dbase.sql
	git commit -m "Automated $DBNAME backup"

	echo "git pushing"
	git push 
else
	echo "there were no changes to commit"
fi
