FROM ubuntu:latest
MAINTAINER pratik

RUN apt-get update && \
    apt-get -y install apache2 php5 php5-mysql && \
    apt-get install wget -y
RUN cd /var/www
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz -C /var/www/
RUN cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
RUN sed -i 's/database_name_here/wordpress/' /var/www/wordpress/wp-config.php
RUN sed -i 's/username_here/wordpress1/' /var/www/wordpress/wp-config.php
RUN sed -i 's/password_here/password/' /var/www/wordpress/wp-config.php
RUN sed -i &amp;quot;s/localhost/ip of the host server of mysql container/g&amp;quot; wordpress/wp-config.php &amp;lt;em&amp;gt;//***&amp;lt;/em&amp;gt;
RUN cd /etc/apache2/sites-enabled/
RUN sed -i 's/\/var\/www\/html/\/var\/www\/wordpress/' /etc/apache2/sites-enabled/000-default.conf

CMD [&amp;quot;apache2ctl&amp;quot; ,&amp;quot; -DFOREGROUND&amp;quot;]
