# Gebruik een ARG voor de PHP-versie
ARG PHP_VERSION=8.4
FROM php:${PHP_VERSION}-fpm

# Install system dependencies for PHP extensions
RUN apt-get update && \
    apt-get install -y \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libonig-dev \
        libpng-dev \
        nginx && \
    rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install \
    ctype \
    curl \
    dom \
    fileinfo \
    filter \
    mbstring \
    pdo \
    pdo_mysql \
    session \
    xml \
    intl \
    gd

# Set the working directory
WORKDIR /var/www/ludwig

# Expose port 9000
EXPOSE 9000

# Default command
CMD ["php-fpm"]