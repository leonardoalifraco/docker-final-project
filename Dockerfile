FROM ubuntu:14.04.2

MAINTAINER lalifraco@devspark.com

# Update apt repositories and upgrade system / applications
RUN sudo apt-get -y update

# Install apache, php5 and mysql 
RUN sudo apt-get install -y apache2 \
	libapache2-mod-php5 \
	php5-mysql \
	php5-gd \
	php-pear \
	php-apc \
	php5-curl \
	curl \
	lynx-cur

# Enable apache mods
RUN a2enmod php5
RUN a2enmod rewrite

# Define environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

ENV WORLD_API_DOCUMENT_ROOT /opt/www/worldapi/public/
ENV WORLD_API_SERVER_NAME api.world.com.ar

# Copy apache configuration files
COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./worldapi.conf /etc/apache2/sites-available/worldapi.conf

RUN a2ensite worldapi.conf

# Copy entrypoint script and set it
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 100 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]