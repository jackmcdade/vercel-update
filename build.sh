#!/bin/sh

# Install PHP 8.3 and its dependencies
dnf install -y php8.3 php8.3-cli php8.3-fpm php8.3-common \
    php8.3-xml php8.3-mbstring php8.3-zip php8.3-curl \
    php8.3-gd php8.3-mysqlnd php8.3-intl php8.3-opcache

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# Install dependencies and generate static files
composer install --no-dev --optimize-autoloader
php please ssg:generate
