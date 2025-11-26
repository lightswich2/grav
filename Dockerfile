FROM php:8.1-cli

# Install system dependencies and PHP extensions Grav needs
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libonig-dev \
    libzip-dev \
    libpng-dev \
    && docker-php-ext-install mbstring zip gd \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Grav files
COPY . /app

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm composer-setup.php

# Install Grav dependencies
RUN composer install --no-interaction --optimize-autoloader

# Run Grav installer to initialize /user/ folder
RUN php bin/grav install

# Expose port 8080
EXPOSE 8080

# Start Grav using PHP’s built-in server
CMD ["php", "-S", "0.0.0.0:8080", "system/router.php"]
