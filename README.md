# This project has been created as part of the 42 curriculum by qmennen

## Description

This project aims to help students understand Docker technology. By doing so, students are required to
familiarize themselves with various aspects of system administration. Students are asked to create a small Docker network
made up of 3 containers with very distinct responsibilities:

- A container running MariaDB
  - Host the database
- A container running Nginx
  - Run a web server on ports 80 and 443 as the only entry point into the network
- A container running PHP-FPM / WordPress.
  - Host the website

## Instructions

Running the project requires some, but not a lot, of setting up.

1. Update the variables defined in the env file located in `srcs/.env` (optional)
2. Create the required secrets _db_password.txt_, _db_root_password.txt_, _wp_admin_password.txt_, and _wp_password.txt_ in the `./secrets` folder.
3. Build & run the containers using `make up`

## Resources

The following resources were used to help realize the project:

- "Compose file reference" https://docs.docker.com/reference/compose-file/
-  https://aws.amazon.com/compare/the-difference-between-docker-vm/
- "Inception" https://medium.com/@imyzf/inception-3979046d90a0 Published: June 5th 2024

A.I. was mostly used to help debug various issues regarding:

- The persistent volumes not being deleted
- Endless MariaDB startup issues
- Nginx being stuck on 403

## Project Description

**Project Structure:**

- **Nginx container**: Reverse proxy and TLS (ports 80/443)
- **WordPress container**: PHP-FPM web server
- **MariaDB container**: Database server

Each container is built based on `debian:bookworm`, following the project requirement not to use pre-built images.

---

## Design Choices

1. **Custom entrypoint scripts**: Each service uses a shell script to handle initialization (database setup, WordPress installation, etc.) before starting the main process.
2. **Docker secrets**: Sensitive data (passwords) are stored in files and mounted read-only at `/run/secrets/`.
3. **Bridge network**: Isolated internal network for container-to-container communication.

---

## Virtual Machines vs Docker

Virtual machines and Docker images differ in some critical aspects, such as:

- **Resource usage**: Virtual machines boot a completely isolated OS, whereas Docker containers share the host kernel and avoid running a full OS.
- **Portability**: Docker images run consistently on any host with the same CPU architecture and Docker runtime, without being tied to a specific hypervisor.
- **Virtualization**: A virtual machine virtualizes a machine’s physical hardware to run an OS, whereas Docker is designed to run applications on top of the host OS.

> VMs allow you to run any operating system on any machine. Docker allows you to run any application on any operating system.

## Secrets vs Environment Variables

It's important to note that both secrets and environment variables can be used to expose dynamic data to the container. The difference between them is essential, however, and implied in the name: secrets are hidden.
A container’s environment variables can be compromised if a hacker gains access to your Docker daemon. Test this yourself by running a container and inspecting it using `docker inspect ...`. Under the `Config` entry, you will be able to see all environment variables and their values as they are used in the container. You’ll notice the secrets aren’t there.

---

## Docker Network vs Host Network

As required by the subject, this project uses a bridge network instead of the host network. This is mostly motivated by security. By using the bridge network, we ensure that the containers are part of a closed-system network with their own private IPs. To allow entry into the network, we need to explicitly expose ports, and containers are able to communicate via container names. Using the host network would mean we lose all of this added security because we’re sharing the host’s network driver, so other applications (and even users, if they enter our host) have access to the containers.

## Docker Volumes vs Bind Mounts

Docker volumes differ from bind mounts in that they’re not bound directly to the host’s filesystem. As the name “bind mount” implies, bind mounts are bound directly to the host’s filesystem and mounted onto the container. Docker volumes are managed by Docker and stored under `/var/lib/docker/volumes`. The subject requires us to use named volumes and not bind mounts, but it does ask us to store the data in `/home/login/data`, which is contradictory. To solve this, I’ve used a named volume that uses a bind mount as its storage driver. This seems like the only logical solution.

```yaml
volumes:
  mariadb_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: ${DATA_DIR}/mariadb_data
```
