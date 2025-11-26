# Use official PHP image (CLI variant is fine for Grav)
FROM php:8.1-cli

# Install required system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libonig-dev \
    && docker-php-ext-install mbstring \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /app

# Copy Grav files into the container
COPY . /app

# Run Grav installer during build to initialize /user/ folder
RUN php bin/grav install

# Expose port 8080 (Render expects this)
EXPOSE 8080

# Start Grav using PHP’s built-in server and router
CMD ["php", "-S", "0.0.0.0:8080", "system/router.php"]

