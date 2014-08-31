FROM chocobozzz/diaspora-docker:without_http_sql
MAINTAINER Florian Bigard <florian.bigard@gmail.com>

ENV MYSQLTMPROOT temprootpass

# Update and upgrade
RUN apt-get update
RUN apt-get -y upgrade

# Install Apache
RUN apt-get -y install -t wheezy-backports nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Install MySQL
RUN echo mysql-server mysql-server/root_password password $MYSQLTMPROOT | debconf-set-selections;\
  echo mysql-server mysql-server/root_password_again password $MYSQLTMPROOT | debconf-set-selections;\
    apt-get install -y mysql-server

RUN apt-get clean

ADD install.sh /home/diaspora/install.sh
ADD start.sh /home/diaspora/start.sh

ADD database.yml  /home/diaspora/diaspora/config/database.yml
ADD diaspora.yml  /home/diaspora/diaspora/config/diaspora.yml
ADD diaspora.crt  /home/diaspora/diaspora.crt
ADD diaspora.key  /home/diaspora/diaspora.key

RUN /home/diaspora/install.sh

ADD diaspora.conf /etc/nginx/sites-enabled/diaspora.conf
RUN rm /etc/nginx/sites-enabled/default

EXPOSE 80
EXPOSE 443
CMD ["/bin/bash", "/home/diaspora/start.sh"] 
