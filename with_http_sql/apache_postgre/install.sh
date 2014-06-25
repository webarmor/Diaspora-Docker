#!/bin/bash

mysqlRoot="mysqlroot"
mysqlDiaspora=$(grep "[^#]password" /home/diaspora/diaspora/config/database.yml | sed "s/\(\s*password:\s*\"\)//" | sed "s/\"\s*$//")

# Create MySQL user
sudo -u postgres psql --command "CREATE USER diaspora WITH PASSWORD '$mysqlDiaspora';"
sudo -u postgres psql --command "CREATE DATABASE diaspora_production OWNER diaspora TEMPLATE DEFAULT;"
sudo -u postgres psql --command "GRANT SELECT, LOCK TABLES, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX ON DATABASE diaspora_production to diaspora;"

sudo -u diaspora -i /bin/bash --login /home/diaspora/install_diaspora.sh
