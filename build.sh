#!/bin/bash

# Download and install PHP 8.3
curl -sL https://rpm.nodesource.com/setup_16.x | bash -
curl -o php83.tar.gz https://www.php.net/distributions/php-8.3.0.tar.gz
tar xzf php83.tar.gz
cd php-8.3.0
./configure --prefix=/usr/local/php8.3 \
    --with-curl \
    --with-openssl \
    --with-zlib \
    --enable-mbstring \
    --enable-xml \
    --enable-fpm \
    --enable-intl \
    --enable-zip
make
make install
cd ..
ln -s /usr/local/php8.3/bin/php /usr/local/bin/php

# Verify PHP installation
php -v

# INSTALL COMPOSER
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# INSTALL COMPOSER DEPENDENCIES
composer install --no-dev --optimize-autoloader

# GENERATE APP KEY
php artisan key:generate

# BUILD STATIC SITE
php please ssg:generate
