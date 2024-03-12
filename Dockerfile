FROM php:8.3-fpm

# Install system dependencies for PHP extensions
RUN apt-get update && \
    apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev libonig-dev libpng-dev nginx && \
    rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install ctype curl dom fileinfo filter mbstring pdo pdo_mysql session xml intl

# Set the working directory
WORKDIR /var/www

EXPOSE 9000
CMD ["php-fpm"]
