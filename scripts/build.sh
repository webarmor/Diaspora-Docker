#!/bin/bash

basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

declare -A paths=( 
  ["without_http_sql"]="$basePath/../without_http_sql/"
  ["with_apache_mysql"]="$basePath/../with_http_sql/apache_mysql/"
  ["with_apache_postgre"]="$basePath/../with_http_sql/apache_postgre"
  ["with_nginx_mysql"]="$basePath/../with_http_sql/nginx_mysql"
  ["with_nginx_postgre"]="$basePath/../with_http_sql/nginx_postgre"
  ["dev_nginx_mysql"]="$basePath/../dev/nginx_mysql"
  ["apache_mysql_example"]="$basePath/../example/apache_mysql/"
  ["apache_postgre_example"]="$basePath/../example/apache_postgre"
  ["nginx_mysql_example"]="$basePath/../example/nginx_mysql"
  ["nginx_postgre_example"]="$basePath/../example/nginx_postgre"
)

function print_help {
  echo -e "Please, choose what you want to build :"
  echo -e "\t1)  Without HTTP server and SQL DBMS"
  echo -e "\t2)  With Apache and MySQL"
  echo -e "\t3)  With Apache and PostgreSQL"
  echo -e "\t4)  With NGinx and MySQL"
  echo -e "\t5)  With NGinx and PostgreSQL"
  echo -e "\t6)  With NGinx and MySQL (for development)"
  echo -e "\t7)  Apache and MySQL example"
  echo -e "\t8)  Apache and PostgreSQL example"
  echo -e "\t9)  NGinx and MySQL example"
  echo -e "\t10) NGinx and PostgreSQL example"
  echo -e "\t*)  Quit\n"
}

function without_http_sql {
  sudo docker build -t chocobozzz/diaspora-docker:without_http_sql ${paths["without_http_sql"]}
}

function with_apache_mysql {
  sudo docker build -t chocobozzz/diaspora-docker:with_apache_mysql ${paths["with_apache_mysql"]}
}

function with_apache_postgre {
  sudo docker build -t chocobozzz/diaspora-docker:with_apache_postgre ${paths["with_apache_postgre"]}
}

function with_nginx_mysql {
  sudo docker build -t chocobozzz/diaspora-docker:with_nginx_mysql ${paths["with_nginx_mysql"]}
}

function with_nginx_postgre {
  sudo docker build -t chocobozzz/diaspora-docker:with_nginx_postgre ${paths["with_nginx_postgre"]}
}

function dev_nginx_mysql {
  sudo docker build -t chocobozzz/diaspora-docker:dev_nginx_mysql ${paths["dev_nginx_mysql"]}
}

function apache_mysql_example {
  sudo docker build -t chocobozzz/diaspora-docker:apache_mysql ${paths["apache_mysql_example"]}
}

function apache_postgre_example {
  sudo docker build -t chocobozzz/diaspora-docker:apache_postgre ${paths["apache_postgre_example"]}
}

function nginx_mysql_example {
  sudo docker build -t chocobozzz/diaspora-docker:nginx_mysql ${paths["nginx_mysql_example"]}
}

function nginx_postgre_example {
  sudo docker build -t chocobozzz/diaspora-docker:nginx_postgre ${paths["nginx_postgre_example"]}
}

print_help
read choice

case $choice in
  1) without_http_sql ;;
  2) with_apache_mysql ;;
  3) with_apache_postgre ;;
  4) with_nginx_mysql ;;
  5) with_nginx_postgre ;;
  6) dev_nginx_mysql ;;
  7) apache_mysql_example ;;
  8) apache_postgre_example ;;
  9) nginx_mysql_example ;;
  10) nginx_postgre_example ;;
esac
