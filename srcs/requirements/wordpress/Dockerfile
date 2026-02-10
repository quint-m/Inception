FROM debian:12

RUN apt-get update && \
    apt-get install -y php8.2-fpm php8.2-mysql php8.2-cli php8.2-cgi php8.2-gd php8.2-xml php8.2-mbstring php8.2-curl php8.2-zip php8.2-intl php8.2-soap php8.2-bcmath curl mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Create required directories
RUN mkdir -p /var/run/php && chown www-data:www-data /var/run/php

# Expose port 9000 for PHP-FPM
EXPOSE 9000

COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]