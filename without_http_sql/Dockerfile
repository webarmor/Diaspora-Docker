FROM debian:wheezy
MAINTAINER Florian Bigard <florian.bigard@gmail.com>

# NodeJS
RUN echo "deb http://http.us.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install net-tools gawk libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake bison libffi-dev subversion bzip2 sudo ps-watcher nodejs build-essential libssl-dev libcurl4-openssl-dev libxml2-dev libxslt-dev imagemagick git-core curl libmysqlclient-dev libmagickwand-dev
RUN apt-get -y install -t wheezy-backports redis-server

RUN apt-get clean

RUN useradd -m -d /home/diaspora -s /bin/bash -p diaspora diaspora ; cd /home/diaspora ; curl -4 -L dspr.tk/1t | sudo -u diaspora -i

WORKDIR /home/diaspora
RUN sudo -u diaspora -i rvm autolibs read-only ; sudo -u diaspora -i rvm install 2.0.0-p353
RUN echo 'export PATH="$PATH:/home/diaspora/.rvm/gems/ruby-2.0.0-p353/wrappers"' >> .bashrc
RUN sudo -u diaspora git clone -b master https://github.com/diaspora/diaspora.git

WORKDIR diaspora
