FROM php:7.4-fpm

# Instalação de algumas extensões
RUN docker-php-ext-install pdo pdo_mysql exif mysqli

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        graphviz \
        zip      \
    # && docker-php-ext-configure gd \
    # && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip \
    && docker-php-source delete

#GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j "$(nproc)" gd

# Instalação e configuração do XDebug
RUN yes | pecl install xdebug && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer