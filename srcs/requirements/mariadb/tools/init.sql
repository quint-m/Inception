-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS wordpress;

-- Create user if it doesn't exist (MariaDB 10.1+)
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'password';

-- Grant privileges
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;