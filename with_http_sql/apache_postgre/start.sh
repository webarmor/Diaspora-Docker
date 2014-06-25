sudo -u postgres /usr/lib/postgresql/9.1/bin/postgres -D /etc/postgresql/9.1/main -c config_file=/etc/postgresql/9.1/main/postgresql.conf &

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_LOG_DIR=/var/log/apache2
export APACHE_RUN_DIR=.
/usr/sbin/apache2 -D BACKGROUND

sleep 20

sudo -u diaspora -i DB=postgres "/home/diaspora/diaspora/script/server"
