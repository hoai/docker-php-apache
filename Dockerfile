FROM php:7.1.14-apache

# install supporting packages
RUN apt-get update && apt-get install -y --fix-missing \
    build-essential \
    pkg-config \
    git-core \
    autoconf \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libcurl4-openssl-dev \
    libpq-dev \
    libpspell-dev \
    libmemcached-dev \
    libmemcached11 \
    libsqlite3-dev \
    libmagickwand-dev \
    imagemagick \
    subversion \
    python \
    g++ \
    curl \
    vim \
    wget \
    netcat \
    chrpath

# install officially supported php extensions
RUN docker-php-ext-install \
    iconv \
    mcrypt \
    opcache \
    curl \
    gd \
    mysqli \
    pdo \
    pdo_pgsql \
    pdo_mysql \
    pdo_sqlite \
    pspell \
    pgsql \
    soap \
    zip

# install memcached extension
COPY scripts/install-php-memcached.sh /install-php-memcached.sh
RUN bash /install-php-memcached.sh && rm /install-php-memcached.sh

# install imagick extension
COPY scripts/install-php-imagick.sh /install-php-imagick.sh
RUN bash /install-php-imagick.sh && rm /install-php-imagick.sh

# install redis / xdebug extensions
RUN pecl install redis xdebug
RUN docker-php-ext-enable \
    redis \
    xdebug

# install composer
WORKDIR /tmp
RUN wget https://getcomposer.org/composer.phar
RUN mv composer.phar /bin/composer
RUN chmod 700 /bin/composer

# cleanup apt
RUN apt-get clean
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/src/*

# enable apache modules
RUN a2enmod rewrite headers cache cache_disk expires vhost_alias

# copy php.ini
COPY php.ini /usr/local/etc/php/conf.d

# copy apache config
COPY /000-default.conf /etc/apache2/sites-enabled/000-default.conf

# entrypoint/command
COPY docker-entrypoint /usr/local/bin/
RUN chmod 700 /usr/local/bin/docker-entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
CMD ["apache2-foreground"]
