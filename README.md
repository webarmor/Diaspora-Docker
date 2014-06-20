# Diaspora-Docker

## Steps : 

 - build **without_http_sql** from **Debian Wheezy**
 - build **with_http_sql** from **without_http_sql** 
 - build **final diaspora** from **with_http_sql**

## Without_http_sql

The Dockerfile :

 - Install all packages needed by Diaspora (ruby from rvm)
 - Add diaspora user
 - Clone diaspora repository

## With_http_sql

The Dockerfile :
    
 - Install apache/nginx 
 - Enable modules for the http server
 - Install mysql/postgresql with a default password
 - Add shell scripts to install and start diaspora
 - Add triggers instruction when the image will be used as the base for the final build (add configurations, run install scripts ...)


## Final (Example)

The Dockerfile just build an image from a **with_http_sql** image. You have to put in the directory of the Dockerfile :
    
 - database.yml with the password you want for diaspora
 - diaspora.conf (conf for the http server)
 - diaspora.crt
 - diaspora.key
 - diaspora.yml
