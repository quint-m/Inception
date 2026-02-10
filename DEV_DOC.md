## Developer Documentation

Contributing to this project has been made as easy as possible. 

### 1. Setup

**Prerequisites**

- Docker Engine and Docker Compose v2
- Make

**Project layout**

- `srcs/docker-compose.yml`: Compose definition
- `srcs/requirements/**`: Dockerfiles, configs, and entrypoints
- `secrets/*.txt`: Secrets mounted into containers
- `/home/qmennen/data/`: Persistent storage on the host (bind-backed named volumes)
- `Makefile`: Common build/run targets

**Configuration**

1. Update/Create `srcs/.env` with the required variables
   - `DOMAIN_NAME=...`
   - `MYSQL_DATABASE=...`
   - `MYSQL_USER=...`
   - `DATA_DIR=...`
2. Create secrets in `./secrets/`:
   - `db_password.txt`
   - `db_root_password.txt`
   - `wp_password.txt`
   - `wp_admin_password.txt`
3. Make sure data folders exist
	- ${DATA_DIR}/mariadb_data
	- ${DATA_DIR}/wordpress_data

### 2. Building and Running

From the project root:

- Build and run: `make up`
- Stop the stack: `make down`
- Rebuild without cache and restart: `make re`

Or, use the compose file correctly:

- `docker compose -f srcs/docker-compose.yml up --build`
- `docker compose -f srcs/docker-compose.yml down`

### 3. Data Storage

Persistent data is stored on the host under a directory defined by the `DATA_DIR` environment variable.
By default, data lives in:

- `DATA_DIR/mariadb_data` (MariaDB)
- `DATA_DIR/wordpress_data` (WordPress)

In Compose, these are **named volumes** that use the local driver with bind options:

```yaml
volumes:
	mariadb_data:
		driver: local
		driver_opts:
			type: none
			o: bind
			device: ${DATA_DIR}/mariadb_data
	wordpress_data:
		driver: local
		driver_opts:
			type: none
			o: bind
			device: ${DATA_DIR}/wordpress_data
```

Keep in mind that deleteing the containers doesn't automagically remove the volumes, since they're bound to your filesystem.
To get rid of the volumes you can:

1. `make clean`
2. Manually remove them:
    - `docker compose -f srcs/docker-compose.yml down -v`
    - `sudo rm -rf ${DATA_DIR}/mariadb_data/* ${DATA_DIR}/wordpress_data/*`

### 4. Port updates

Especially for changing the nginx port keep in mind that the WP site url and home option also save the port.
To update this, change the ${DOMAIN} env and update the database settings using `wp option update siteurl "https://domain.42.fr:port"` and `wp option update home "https://domain.42.fr:port"`
