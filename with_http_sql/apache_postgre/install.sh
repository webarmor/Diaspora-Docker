#!/bin/bash

mysqlRoot="mysqlroot"
mysqlDiaspora=$(grep "^\s*[^#]\s*password" /home/diaspora/diaspora/config/database.yml | sed "s/\(\s*password:\s*\"\)//" | sed "s/\"\s*$//")

sudo -u postgres /usr/lib/postgresql/9.4/bin/postgres -D /etc/postgresql/9.4/main -c config_file=/etc/postgresql/9.4/main/postgresql.conf &
sleep 20

sudo -u postgres psql --command "CREATE USER diaspora WITH PASSWORD '$mysqlDiaspora';"
sudo -u postgres psql --command "CREATE DATABASE diaspora_production OWNER diaspora TEMPLATE DEFAULT;"
sudo -u postgres psql --command "GRANT ALL PRIVILEGES ON DATABASE diaspora_production to diaspora;"

sudo -u diaspora -i /bin/bash /home/diaspora/install_diaspora.sh
