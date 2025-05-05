FROM php:8.3-apache

RUN apt-get update
RUN apt-get install -y git libzip-dev zip unzip npm
RUN docker-php-ext-install pdo pdo_mysql zip
RUN libzip-dev\
  libjpeg-dev \
  libpng-dev \
  libfreetype6-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd pdo pdo_mysql\
  && docker-php-ext-install zip \
  && docker-php-ext-enable zip \
  && rm -rf /var/lib/apt/lists/*
RUN a2enmod rewrite
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install lets encrypt
RUN apt-get -y install certbot python3-certbot-apache
