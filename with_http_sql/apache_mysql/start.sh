/usr/bin/mysqld_safe & 

/usr/bin/redis-server &

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_LOG_DIR=/var/log/apache2
export APACHE_RUN_DIR=.
/usr/sbin/apache2 -D BACKGROUND

sleep 5

sudo -u diaspora -i rvm use 2.0
echo 'cd /home/diaspora/diaspora/ && script/server' | sudo -u diaspora -i
