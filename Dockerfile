FROM ubuntu:14.04

MAINTAINER leonardo.alifraco@gmail.com

# Update apt repositories and upgrade system / applications
RUN sudo apt-get -y update # && apt-get -y upgrade

# Install apache, php5 and mysql 
RUN sudo apt-get install -y apache2 libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc php5-curl curl lynx-cur

RUN a2enmod php5
RUN a2enmod rewrite

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

ENV WORLD_API_DOCUMENT_ROOT /opt/www/worldapi/public/
ENV WORLD_API_SERVER_NAME api.world.com.ar

EXPOSE 80

ADD ./apache2.conf /etc/apache2/apache2.conf
ADD ./worldapi.con /etc/apache2/sites-available/worldapi.conf

RUN a2ensite worldapi.conf

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]