#!/bin/bash
set -e

echo "Starting MariaDB entrypoint script..."

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_DATABASE=${MYSQL_DATABASE:-wordpress}
MYSQL_USER=${MYSQL_USER:-wpuser}

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    echo "Starting temporary MariaDB instance..."
    mysqld --user=mysql --datadir=/var/lib/mysql \
           --socket=/var/run/mysqld/mysqld.sock \
           --pid-file=/var/run/mysqld/mysqld.pid \
           --skip-networking \
           --skip-grant-tables &
    MYSQL_PID=$!
    
    echo "Waiting for MariaDB to be ready..."
    while ! mysqladmin ping --socket=/var/run/mysqld/mysqld.sock --silent; do
        sleep 1
    done

    echo "Creating database and user..."
    # Create database and user
    mysql --socket=/var/run/mysqld/mysqld.sock << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
GRANT CREATE ON *.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

    # Shutdown the temporary instance
    mysqladmin --socket=/var/run/mysqld/mysqld.sock -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
    wait $MYSQL_PID

    echo "Database initialization complete."
else
    echo "MariaDB data directory already exists, skipping initialization."
fi

echo "Starting MariaDB normally..."
# Start MariaDB normally
exec mysqld --user=mysql --datadir=/var/lib/mysql