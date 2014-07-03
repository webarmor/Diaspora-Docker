#!/bin/bash

mysqlRoot="mysqlroot"
mysqlDiaspora=$(grep "^\s*[^#]\s*password" /home/diaspora/diaspora/config/database.yml | sed "s/\(\s*password:\s*\"\)//" | sed "s/\"\s*$//")

# Start MySQL
mysqld_safe &
sleep 5

# Create MySQL user
mysqladmin -u root --password=temprootpass password $mysqlRoot
echo "CREATE USER 'diaspora'@'localhost' IDENTIFIED BY '$mysqlDiaspora';" | \
    mysql --user=root --password=$mysqlRoot
echo "CREATE DATABASE IF NOT EXISTS diaspora_development DEFAULT CHARACTER SET \
        'utf8' COLLATE 'utf8_unicode_ci';" | mysql --user=root --password=$mysqlRoot
echo "GRANT SELECT, LOCK TABLES, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, \
        ALTER ON diaspora_development.* TO 'diaspora'@'localhost';" | mysql \
            --user=root --password=$mysqlRoot

echo "CREATE DATABASE IF NOT EXISTS diaspora_test DEFAULT CHARACTER SET \
        'utf8' COLLATE 'utf8_unicode_ci';" | mysql --user=root --password=$mysqlRoot
echo "GRANT SELECT, LOCK TABLES, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, \
        ALTER ON diaspora_test.* TO 'diaspora'@'localhost';" | mysql \
            --user=root --password=$mysqlRoot


sudo -u diaspora -i /bin/bash --login /home/diaspora/install_diaspora.sh
