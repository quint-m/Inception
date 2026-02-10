#!/bin/bash

cd /var/www/html

if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if ! wp core is-installed 2>/dev/null; then
    wp core download --allow-root --path="/var/www/html"
    wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=$(cat /run/secrets/db_password) --dbhost=mariadb --allow-root
    wp db create --allow-root 2>/dev/null || echo "Database already exists"
    wp core install --url=${DOMAIN_NAME} --title="Inception" --admin_user=${WP_ADMIN} --admin_password=$(cat /run/secrets/wp_admin_password) --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root
    wp user create --allow-root $WP_AUTHOR $WP_AUTHOR_EMAIL --role=author --user_pass=$(cat /run/secrets/wp_password) --path=/var/www/html
fi

php-fpm8.2 -F