# Diaspora-Docker

## HOW TO

See (HOW TO Wiki)[https://github.com/Chocobozzz/Diaspora-Docker/wiki/How-To]

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
 - Enable modules for the http server (apache)
 - Install mysql/postgresql with a default password
 - Add shell scripts to install and start diaspora
 - Add triggers instruction when the image will be used as the base for the final build (add configurations, run install scripts ...)


### Dev (without assets precompiled)

From the **without_http_sql** image, the Dockerfile :
    
 - Install nginx 
 - Install mysql
 - Add default configuration files
 - Install Diaspora without assets precompiled
 - Autostart Diaspora when run the image 


### Final (Example)

From the **with_http_sql** image, the Dockerfile builds the final Diaspora image with the configuration you want. You have to put in the directory of the Dockerfile :
    
 - database.yml with the password you want for diaspora
 - diaspora.conf (conf for the http server)
 - diaspora.crt
 - diaspora.key
 - diaspora.yml


