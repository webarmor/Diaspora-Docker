sudo -u postgres /usr/lib/postgresql/9.3/bin/postgres -D /data/main -c config_file=/data/postgresql.conf &

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_LOG_DIR=/var/log/apache2
export APACHE_RUN_DIR=.
/usr/sbin/apache2 -D BACKGROUND

sleep 5

sudo -u diaspora -i "/home/diaspora/diaspora/script/server"
