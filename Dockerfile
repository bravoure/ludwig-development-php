# Gebruik een ARG voor de PHP-versie
ARG PHP_VERSION=8.4
FROM php:${PHP_VERSION}-fpm

# Setup general options for environment variables
ARG PHP_MEMORY_LIMIT_ARG="1024M"
ENV PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT_ARG}
ARG PHP_MAX_EXECUTION_TIME_ARG="120"
ENV PHP_MAX_EXECUTION_TIME=${PHP_MAX_EXECUTION_TIME_ARG}

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

# Create a generic non-root user
RUN useradd -ms /bin/bash appuser

# Create the working directory and set permissions
RUN mkdir -p /var/www/ludwig && chown -R appuser:appuser /var/www/ludwig

# Copy PHP custom ini settings with correct ownership
COPY --chown=appuser:appuser php-custom.ini /usr/local/etc/php/conf.d/

# Switch to non-root user
USER appuser

# Set the working directory
WORKDIR /var/www/ludwig

# Expose port 9000
EXPOSE 9000

# Default command
CMD ["php-fpm"]