#!/bin/bash

# Check that a parameter was passed in
if [ "$1" = "" ]
then
	echo -e "you must pass in a db name"
	exit 1
fi

echo -e "Exporting Git Log to sql dump"
git log --format="INSERT IGNORE INTO gitlog (id, hash, date, user_name, message) VALUES (NULL, \"%H\", \"%ct\", \"%an\", REPLACE(\"%f\", \"-\", \" \"));" > gitlog.sql

echo -e "Importing SQL dump to $1 database"
mysql --user=gitlog --pass=gitlog $1 < gitlog.sql

echo -e "Deleting sql dump"
rm gitlog.sql

echo -e "updating version number"
mysql --user=gitlog --pass=gitlog "INSERT INTO git_version (`date`) VALUES(UNIX_TIMESTAMP())"
