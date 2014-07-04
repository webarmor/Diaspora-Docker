# Ruby
source /root/.bashrc

/usr/bin/mysqld_safe & 

/usr/bin/redis-server &

/usr/sbin/nginx &

sleep 5

/home/diaspora/diaspora/script/server
