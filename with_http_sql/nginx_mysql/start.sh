/usr/bin/mysqld_safe & 

/usr/bin/redis-server &

/usr/sbin/nginx &

sleep 5

sudo -u diaspora -i rvm use 2.0
echo 'cd /home/diaspora/diaspora/ && script/server' | sudo -u diaspora -i
