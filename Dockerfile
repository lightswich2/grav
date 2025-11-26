FROM php:8.1-cli

# Install dependencies
RUN apt-get update && apt-get install -y unzip git \
    && docker-php-ext-install mbstring

# Set working directory
WORKDIR /app

# Copy Grav files
COPY . /app

# Expose port
EXPOSE 8080

# Start Grav using its router
CMD ["php", "-S", "0.0.0.0:8080", "system/router.php"]
