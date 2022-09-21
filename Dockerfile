FROM php:8.1.11RC1-fpm-buster

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN mkdir -p /var/www/html

WORKDIR /var/www/html
RUN apt-get update \
  && apt-get install -y libzip-dev libpng-dev libwebp-dev libgmp-dev libldap2-dev libfreetype6-dev libjpeg62-turbo-dev \
  && docker-php-ext-install zip \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif 