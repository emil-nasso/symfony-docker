FROM debian:8

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    less \
    curl \
    libapache2-mod-php5 \
    nano \
    php5 \
    php5-cli \
    php5-curl \
    php5-mcrypt \
    php5-mysql \
    php5-intl \
    php5-xdebug \
    php5-memcached \
    augeas-tools


### setup php + composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
RUN sed  -i "s#memory_limit = 128M#memory_limit = 256M#" /etc/php5/apache2/php.ini

### setup uid/gid
RUN find / -user www-data -exec chown 1000 {} + 2>/dev/null || true
RUN usermod -u 1000 www-data

COPY ./docker/apache-vhost.conf /etc/apache2/sites-enabled/000-default.conf

### update apache config
RUN a2enmod rewrite

### copy app files + cleanup
#COPY . /var/www

COPY ./docker/config.aug /etc/
RUN augtool -s -f /etc/config.aug

COPY docker/symfony_environment.sh /etc/symfony_environment.sh
RUN echo "source /etc/symfony_environment.sh" >> /etc/bash.bashrc

### docker image settings
EXPOSE 80

COPY ./docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
