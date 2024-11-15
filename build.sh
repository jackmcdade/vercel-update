#!/bin/sh

# Add Ondrej PHP repository
apt-get update
apt-get install -y software-properties-common
add-apt-repository -y ppa:ondrej/php
apt-get update

# Install PHP 8.3 and required extensions
apt-get install -y php8.3 \
    php8.3-common \
    php8.3-curl \
    php8.3-mbstring \
    php8.3-gd \
    php8.3-bcmath \
    php8.3-xml \
    php8.3-fpm \
    php8.3-intl \
    php8.3-zip \
    php8.3-imap \
    wget \
    unzip

# INSTALL COMPOSER
EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
rm composer-setup.php

# INSTALL COMPOSER DEPENDENCIES
php composer.phar install

# GENERATE APP KEY
php artisan key:generate

# BUILD STATIC SITE
php please ssg:generate
