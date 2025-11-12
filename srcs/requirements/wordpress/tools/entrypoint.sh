#!/bin/bash

cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root
wp config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root
wp core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root

php-fpm8.2 -F