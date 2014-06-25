#!/bin/bash

mysqlRoot="mysqlroot"
mysqlDiaspora=$(grep "^\s*[^#]\s*password" /home/diaspora/diaspora/config/database.yml | sed "s/\(\s*password:\s*\"\)//" | sed "s/\"\s*$//")

# Create MySQL user
sudo -u postgres /usr/lib/postgresql/9.1/bin/postgres -D /etc/postgresql/9.1/main -c config_file=/etc/postgresql/9.1/main/postgresql.conf &
sleep 20

sudo -u postgres psql --command "CREATE USER diaspora WITH PASSWORD '$mysqlDiaspora';"
sudo -u postgres psql --command "CREATE DATABASE diaspora_production OWNER diaspora TEMPLATE DEFAULT;"
sudo -u postgres psql --command "GRANT ALL PRIVILEGES ON DATABASE diaspora_production to diaspora;"

sudo -u diaspora -i /bin/bash --login /home/diaspora/install_diaspora.sh
