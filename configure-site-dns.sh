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
