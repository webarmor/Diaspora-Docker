#!/usr/bin/sh

declare -A paths=( 
  ["without_http_sql"]="../without_http_sql/" 
  ["with_apache_mysql"]="../with_http_sql/apache_mysql/" 
  ["with_apache_postgre"]="../with_http_sql/apache_postgre" 
  ["with_nginx_mysql"]="../with_http_sql/nginx_mysql" 
  ["with_nginx_postgre"]="../with_http_sql/nginx_postgre" 
  ["dev_nginx_mysql"]="../dev/nginx_mysql" 
)

function print_help {
  echo -e "Please, choose what you want to build :"
  echo -e "\t1) Without HTTP server and SQL DBMS"
  echo -e "\t2) With Apache and MySQL"
  echo -e "\t3) With Apache and PostgreSQL"
  echo -e "\t4) With NGinx and MySQL"
  echo -e "\t5) With NGinx and PostgreSQL"
  echo -e "\t6) With NGinx and MySQL (for development)"
  echo -e "\t*) Quit"
}

function print_what_next {
  echo -e "\nNow you can build the final image (see the example directory)."
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

print_help
read choice

case $choice in
  1) without_http_sql ;;
  2) with_apache_mysql ;;
  3) with_apache_postgre ;;
  4) with_nginx_mysql ;;
  5) with_nginx_postgre ;;
  6) dev_nginx_mysql ;;
  *) echo "Goodbye." ;;
esac
