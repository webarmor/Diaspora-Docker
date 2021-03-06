sudo -u postgres /usr/lib/postgresql/9.4/bin/postgres -D /etc/postgresql/9.4/main -c config_file=/etc/postgresql/9.4/main/postgresql.conf &

/usr/bin/redis-server &

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_PID_FILE=/var/run/apache2.pid
export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_LOG_DIR=/var/log/apache2
export LANG=C
[ ! -d ${APACHE_RUN_DIR} ] && mkdir -p ${APACHE_RUN_DIR} && chown "${APACHE_RUN_USER}:${APACHE_RUN_GROUP}" ${APACHE_RUN_DIR}
[ ! -d ${APACHE_LOCK_DIR} ] && mkdir -p ${APACHE_LOCK_DIR} && chown "${APACHE_RUN_USER}:${APACHE_RUN_GROUP}" ${APACHE_LOCK_DIR}
/usr/sbin/apache2 -D BACKGROUND

sleep 20

sudo -u diaspora -i /bin/bash -c 'DB=postgres /home/diaspora/diaspora/script/server'
