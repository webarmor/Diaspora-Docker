FROM debian:jessie
MAINTAINER Florian Bigard <florian.bigard@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install net-tools gawk libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake bison libffi-dev subversion bzip2 sudo ps-watcher nodejs build-essential libssl-dev libcurl4-openssl-dev libxml2-dev libxslt-dev imagemagick git-core curl libmysqlclient-dev libmagickwand-dev sendmail redis-server

RUN apt-get clean

RUN useradd -m -d /home/diaspora -s /bin/bash -p diaspora diaspora
RUN echo "curl -sSL https://rvm.io/mpapis.asc | gpg --import -" | sudo -u diaspora -i
RUN cd /home/diaspora ; echo "curl -L https://get.rvm.io | bash -s stable" | sudo -u diaspora -i

WORKDIR /home/diaspora
RUN sudo -u diaspora -i rvm autolibs read-only ; sudo -u diaspora -i rvm install 2.0
RUN echo "source /home/diaspora/.rvm/scripts/rvm && gem install bundle" | sudo -u diaspora -i
RUN sudo -u diaspora git clone https://github.com/diaspora/diaspora.git
RUN echo "cd diaspora && git checkout master" | sudo -u diaspora -i

WORKDIR diaspora
