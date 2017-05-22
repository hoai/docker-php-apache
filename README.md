# PHP/Apache

PHP/Apache docker image for local development. Built from the official `php:7.0-apache` image.

[View on Docker Hub](https://hub.docker.com/r/imarcagency/php-apache)

### Included PHP Extensions

iconv, mcrypt, opcache, curl, gd, mysqli, pdo, pdo\_pgsql, pdo\_mysql, pdo\_sqlite, pgsql, zip, memcached, imagick, redis, xdebug

## Configuration

The following environment variables can be used to configure apache VirtualHost. Look at the `configure` script to see how these variables are used.

- **APACHE_ROOT** (_string_) The DocumentRoot value. Defaults to `/var/www/public`

- **APACHE\_AUTH\_BASIC** (_bool_) Enable Basic Auth by setting to `1`. Defaults to `0`

- **APACHE\_AUTH\_NAME** (_string_) The name of the basic auth prompt. Defaults to `Secured Environment`

- **APACHE\_AUTH\_FILE** (_string_) The path to the .htpasswd file. Defaults to `/var/www/.htpasswd`
