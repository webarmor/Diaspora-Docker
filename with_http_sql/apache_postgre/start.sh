sudo -u postgres /usr/lib/postgresql/9.4/bin/postgres -D /etc/postgresql/9.4/main -c config_file=/etc/postgresql/9.4/main/postgresql.conf &

/usr/bin/redis-server &

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_LOG_DIR=/var/log/apache2
export APACHE_RUN_DIR=.
/usr/sbin/apache2 -D BACKGROUND

sleep 20

sudo -u diaspora -i /bin/bash -c 'DB=postgres /home/diaspora/diaspora/script/server'
