#!/bin/bash
set -e

# download
cd /tmp
git clone https://github.com/php-memcached-dev/php-memcached
cd /tmp/php-memcached
git checkout -b tags/2.2.0

# compile and install
phpize
./configure
make
make install

# cleanup
rm -rf /tmp/php-memcached

echo 'extension=memcached.so' > /usr/local/etc/php/conf.d/memcached.ini
