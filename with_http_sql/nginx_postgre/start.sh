sudo -u postgres /usr/lib/postgresql/9.1/bin/postgres -D /etc/postgresql/9.1/main -c config_file=/etc/postgresql/9.1/main/postgresql.conf &

/usr/bin/redis-server &

/usr/sbin/nginx &

sleep 20

sudo -u diaspora -i /bin/bash -c 'DB=postgres /home/diaspora/diaspora/script/server'
