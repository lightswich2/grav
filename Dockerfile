FROM php:8.1-cli

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libonig-dev \
    && docker-php-ext-install mbstring \
    && rm -rf /var/lib/apt/lists/*


# Set working directory
WORKDIR /app

# Copy Grav files
COPY . /app

# Expose port
EXPOSE 8080

# Start Grav using its router
CMD ["php", "-S", "0.0.0.0:8080", "system/router.php"]
