sudo -u postgres /usr/lib/postgresql/9.1/bin/postgres -D /etc/postgresql/9.1/main -c config_file=/etc/postgresql/9.1/main/postgresql.conf &

/usr/bin/redis-server &

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_LOG_DIR=/var/log/apache2
export APACHE_RUN_DIR=.
/usr/sbin/apache2 -D BACKGROUND

sleep 20

sudo -u diaspora -i rvm use 2.0
echo 'cd /home/diaspora/diaspora/ && DB=postgres script/server' | sudo -u diaspora -i
