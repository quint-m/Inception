# User Documentation

## Overview

This docker swarm provides a basic stack container the following services:

- **Nginx**: Web server handling HTTP/HTTPS.
- **WordPress (PHP-FPM)**: Running the WordPress website.
- **MariaDB**: Database storing WordPress data.

## Running the Project

From the project root, use the Makefile to start and stop the project:

- Start the stack:
  - `make up`
- Stop the stack:
  - `make down`
- Rebuild and restart (if needed):
  - `make re`

## Access the Website and Administrator Panel

1. Ensure your host (found in `./srcs/.env`) resolves your domain (e.g., `qmennen.42.fr`) to `127.0.0.1` and `::1` in `/etc/hosts`.
2. Open the site in a browser:
   - `https://qmennen.42.fr` (or your configured domain)
3. Access the WordPress admin panel:
   - `https://qmennen.42.fr/wp-admin`

## Locating and Managing Credentials

Credentials are stored as Docker secrets in the `secrets/` directory:

- `secrets/db_password.txt`: WordPress database user password
- `secrets/db_root_password.txt`: MariaDB root password
- `secrets/wp_password.txt`: WordPress database user password
- `secrets/wp_admin_password.txt`: Wordpress admin password

If you update a secret file, restart the stack so containers reload the secrets:

- `make down`
- `make up`

## Check That Services Are Running Correctly

Use Docker Compose to check container status:

- `make status`

Expected: all services are `Up`.

To view logs for troubleshooting:

- `make logs`

Of course, seeing if the website is available is the most straightforward way to check if the stack is running correctly.