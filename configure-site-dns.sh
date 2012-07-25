#!/bin/bash

# Check that the script is being run as sudo
if [ "$(id -u)" != "0" ]
then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Check that the first domain was passed in
if [ "$1" = "" ]
then
        echo -e "you must pass in the domain name as parameter 1"
        exit 1
fi

# Check whether the record already exists in the config file
if grep -Fq "$1" /etc/bind/domain-enabled.conf
then
	echo "$1 already exists in dns"
	exit 1
fi

echo -e "adding domain details to /etc/bind/domain-enabled.conf"
cat <<EOF >>/etc/bind/domain-enabled.conf
	zone "$1" {
	        type master;
	        file "/etc/bind/domain-enabled/$1.db";
	};
EOF

echo -e "adding domain conf file to /etc/bind/domain-enabled/"
cat <<EOF >/etc/bind/domain-enabled/$1.db
\$TTL   604800
@       IN      SOA     $1. root.localhost. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.deanrather.com.
@       IN      NS      ns2.deanrather.com.
@       IN      A       23.23.215.12
ns1     IN      A       23.23.215.12
EOF

echo -e "restarting dns"
rndc reload
