#!/bin/bash
set -e

echo "Starting MariaDB entrypoint script..."

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

# Initialize MySQL data directory if it doesn't exist or if our custom database doesn't exist
if [ ! -d "/var/lib/mysql/mysql/.initialized" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MySQL temporarily for setup
    echo "Starting temporary MySQL instance..."
    mysqld --user=mysql --datadir=/var/lib/mysql --socket=/tmp/mysql.sock --skip-grant-tables &
    MYSQL_PID=$!
    
    # Wait for MySQL to be ready
    echo "Waiting for MySQL to be ready..."
    while ! mysqladmin ping --socket=/tmp/mysql.sock --silent; do
        sleep 1
    done
    
    echo "Creating database and user..."
    # Create database and user
    mysql --socket=/tmp/mysql.sock << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

    touch "/var/lib/mysql/mysql/.initialized"
    
    chmod 600 "/var/lib/mysql/mysql/.initialized"
    chown mysql:mysql "/var/lib/mysql/mysql/.initialized"

    mysqladmin --socket=/tmp/mysql.sock -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

    echo "Database initialization complete."
else
    echo "MySQL data directory already exists, skipping initialization."
fi

echo "Starting MySQL normally..."
# Start MySQL normally
exec mysqld --user=mysql --datadir=/var/lib/mysql