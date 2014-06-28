# Diaspora-Docker

## Architecture

### Diagram
![Architecture](https://lut.im/0nwibFDt/MivG8C0P)

### Steps to build an image : 

 - build **without_http_sql** from **Debian Wheezy**
 - build **with_http_sql** from **without_http_sql** 
 - build **final diaspora** from **with_http_sql**

### Without_http_sql

From the **Debian Wheezy** image, the Dockerfile :

 - Install all packages needed by Diaspora (ruby from rvm)
 - Add diaspora user
 - Clone diaspora repository

### With_http_sql

From the **without_http_sql** image, the Dockerfile :
    
 - Install apache/nginx 
 - Enable modules for the http server
 - Install mysql/postgresql with a default password
 - Add shell scripts to install and start diaspora
 - Add triggers instruction when the image will be used as the base for the final build (add configurations, run install scripts ...)


### Final (Example)

From the **with_http_sql** image, the Dockerfile builds the final Diaspora image with the configuration you want. You have to put in the directory of the Dockerfile :
    
 - database.yml with the password you want for diaspora
 - diaspora.conf (conf for the http server)
 - diaspora.crt
 - diaspora.key
 - diaspora.yml

## Installation

### Development

Choose the http server (Apache or NGinx) and the DBMS (MySQL or PostgreSQL) you want. Final images are built to force https with a self signed certificate. The password of diaspora user for database is simply "diaspora_password".

An example for development use could be :

    docker pull chocobozzz/diaspora-docker:final_{apache,nginx}_{mysql,postgre}
    docker run -d -P image_id
    docker ps   # To see https port
    curl https://localhost:https_port -k
    
### Production

Choose the http server (Apache or NGinx) and the DBMS (MySQL or PostgreSQL) you want. Now you have to pull the Docker image which have all dependencies, Diaspora sources, http server, DBMS... :

    docker pull chocobozzz/diaspora-docker:with_{apache,nginx}_{mysql,postgre}

Now you have to create a new Docker image. But you need the configuration files : database.yml, diaspora.conf (http server), diaspora.yml, diaspora.crt and diaspora.key (for SSL) (you have examples in the "example" directory of my Github).
    
    docker build -t chocobozzz/diaspora:{apache,nginx}_{mysql,postgre} dir_which_contains_confs < Dockerfile

During the building, Docker will add your configuration files in the image and will "install" Diaspora. Now, you have the Diaspora you wanted :)

    


