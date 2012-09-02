#!/bin/bash

# Check that the script is being run as sudo
if [ "$(id -u)" != "0" ]
then
   echo "This script must be run as root" 1>&2
   exit 1
fi


read -r -d '' FILECONTENT <<'ENDFILECONTENT'
[www]
listen = 127.0.0.1:9000
listen.allowed_clients = 127.0.0.1
user = www-data
group = www-data
pm = dynamic
pm.max_children = 50
pm.start_servers = 25
pm.min_spare_servers = 5
pm.max_spare_servers = 35
pm.max_requests = 2500
pm.status_path = /php-status
slowlog = log/$pool.log.slow
chdir = /
;php_admin_value[sendmail_path] = /usr/sbin/sendmail -t -i -f www@my.domain.com
;php_flag[display_errors] = off
;php_admin_value[error_log] = /var/log/fpm-php.www.log
;php_admin_flag[log_errors] = on
;php_admin_value[memory_limit] = 32M
ENDFILECONTENT

cp /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf.original
echo "$FILECONTENT" > /etc/php5/fpm/pool.d/www.conf
/etc/init.d/php5-fpm restart
