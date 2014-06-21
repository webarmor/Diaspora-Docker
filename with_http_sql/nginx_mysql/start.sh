/usr/bin/mysqld_safe & 

/usr/sbin/nginx &

sleep 5

sudo -u diaspora -i "/home/diaspora/diaspora/script/server"
