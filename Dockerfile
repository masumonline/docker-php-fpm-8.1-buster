FROM php:8.1.0RC5-fpm-buster

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN mkdir -p /var/www/html

WORKDIR /var/www/html
RUN apt-get update \
     && apt-get install -y libzip-dev libpng-dev \
     && docker-php-ext-install zip

RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif 
RUN docker-php-ext-install gd