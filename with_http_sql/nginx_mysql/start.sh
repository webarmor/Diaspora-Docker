/usr/bin/mysqld_safe & 

/usr/bin/redis-server &

/usr/sbin/nginx &

sleep 5

sudo -u diaspora -i /home/diaspora/diaspora/script/server
