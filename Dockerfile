# Use the official PHP image with Apache
FROM php:8.3-apache

# Install PostgreSQL client and development libraries
RUN apt-get update && \
    apt-get install -y libpq-dev && \
    docker-php-ext-install pgsql pdo pdo_pgsql

# Set the working directory
WORKDIR /var/www/html

# Copy application files to the container
COPY . ./

# Expose port 8080
EXPOSE 8080

# Change Apache to listen to the PORT environment variable, defaulting to 8080
ENV PORT 8080
RUN sed -i "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf && \
    sed -i "s/:80/:${PORT}/" /etc/apache2/sites-available/000-default.conf

# Use the production PHP configuration file
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
