# build from php 5.6
FROM php:5.6-apache

# install supporting packages
RUN apt-get update && apt-get install -y --fix-missing \
    autoconf \
    build-essential \
    chrpath \
    curl \
    g++ \
    git-core \
    imagemagick \
    libcurl4-openssl-dev \
    libjpeg62-turbo-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libmemcached11 \
    libpng12-dev \
    libpq-dev \
    libsqlite3-dev \
    libtidy-dev \
    netcat \
    pkg-config \
    python \
    subversion \
    sudo \
    vim \
    wget

# install officially supported php extensions
RUN docker-php-ext-install \
    iconv \
    mcrypt \
    opcache \
    curl \
    gd \
    mysql \
    mysqli \
    pdo \
    pdo_pgsql \
    pdo_mysql \
    pdo_sqlite \
    pgsql \
    tidy \
    zip

# Install PHP extensions provided by debian
RUN apt install -y php5-memcached php5-imagick php5-mssql php5-redis php5-xdebug

RUN cp /etc/php5/mods-available/imagick.ini /usr/local/etc/php/conf.d/
RUN cp /usr/lib/php5/*/imagick.so /usr/local/lib/php/extensions/*/

RUN cp /etc/php5/mods-available/memcached.ini /usr/local/etc/php/conf.d/
RUN cp /usr/lib/php5/*/memcached.so /usr/local/lib/php/extensions/*/

RUN cp /etc/php5/mods-available/opcache.ini /usr/local/etc/php/conf.d/
RUN cp /usr/lib/php5/*/opcache.so /usr/local/lib/php/extensions/*/

RUN cp /etc/php5/mods-available/redis.ini /usr/local/etc/php/conf.d/
RUN cp /usr/lib/php5/*/redis.so /usr/local/lib/php/extensions/*/

RUN cp /etc/php5/mods-available/xdebug.ini /usr/local/etc/php/conf.d/
RUN cp /usr/lib/php5/*/xdebug.so /usr/local/lib/php/extensions/*/

RUN cp /etc/php5/mods-available/mssql.ini /usr/local/etc/php/conf.d/
RUN cp /usr/lib/php5/*/mssql.so /usr/local/lib/php/extensions/*/


# cleanup apt
RUN apt-get clean
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/src/*

# enable apache modules
RUN a2enmod rewrite headers cache cache_disk expires

# install composer
WORKDIR /tmp
RUN wget https://getcomposer.org/composer.phar
RUN mv composer.phar /bin/composer
RUN chmod 755 /bin/composer

# entrypoint/configuration scripts
COPY entrypoint /opt/entrypoint
COPY configure /opt/configure
RUN chmod 755 /opt/entrypoint
RUN chmod 755 /opt/configure

# set working directory
WORKDIR /var/www

# add and run as docker user
RUN groupadd docker
RUN useradd docker -s /bin/bash -m -g docker
RUN usermod -aG www-data docker
RUN usermod -aG sudo docker
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# give docker user permission to run composer
RUN chown docker:docker /bin/composer

# run comtainer as docker user
USER docker

# entrypoint/command
ENTRYPOINT ["/opt/entrypoint"]
CMD ["sudo", "-E", "apache2-foreground"]
