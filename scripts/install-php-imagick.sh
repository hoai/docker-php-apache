#!/bin/bash
set -e

# https://pecl.php.net/package/imagick

VERSION='3.4.3RC1'

cd /tmp
wget https://pecl.php.net/get/imagick-$VERSION.tgz
tar xvzf imagick-$VERSION.tgz

cd /tmp/imagick-$VERSION
phpize
./configure
make install

rm -rf /tmp/imagick-$VERSION

echo 'extension=imagick.so' > /usr/local/etc/php/conf.d/imagick.ini
