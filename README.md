# Diaspora-Docker

## HOW TO

See [HOW TO Wiki](https://github.com/Chocobozzz/Diaspora-Docker/wiki/How-To)

## Update your image

You have two differents ways to update your image :

### Rebuild the image

You need to export your *database*, the *public/uploads* directory and you configuration files (*config/*). 

Then, you just need to **git pull** or **git clone** the repository and rebuild a new image. In your new image, reimport the *database* and the *public/uploads* repository. 

Finally, you need to modify the new *config/* files to have the same options than the previous image.

### Or update manually

Stop your image :

    # docker stop your_instance_id

Commit your image to save it :

     # docker commit your_instance_id your_image_name:your_tag

Get the tty of your image :

     # docker run -i -t your_image_id
 
Upgrade the system :

     # apt-get update && apt-get upgrade
 
Become the diaspora user :

     # su diaspora
 
Update Diaspora with the updating guide : https://wiki.diasporafoundation.org/Updating

**Note:** If you need to update *rvm*, you'll need to specify the `--default` option with `rvm use`. Example:

    rvm use 2.1 --default

Exit from your image, and commit it :

    # docker commit your_instance_updated_id your_image_updated_name:your_tag

 



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


