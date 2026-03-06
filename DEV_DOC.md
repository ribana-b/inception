# Developer Documentation

## Set Up the Environment from Scratch

### Prerequisites

- Docker Engine
- Docker Compose plugin
- A virtual machine (required by the project)

### Configuration Files

The project uses the following configuration:

- `srcs/.env` - Environment variables (domain name, WordPress title)
- `srcs/docker-compose.yml` - Container orchestration
- `srcs/requirements/nginx/conf/default` - NGINX server configuration
- `srcs/requirements/wordpress/conf/www.conf` - PHP-FPM configuration
- `srcs/requirements/mariadb/conf/50-server.cnf` - MariaDB configuration

### Secrets

Set credentials in the `secrets/` directory before building:

```
secrets/
├── db_name.txt          # Database name
├── db_user_name.txt     # Database username
├── db_user_pass.txt     # Database password
├── wp_admin_user.txt    # Admin username
├── wp_admin_pass.txt    # Admin password
├── wp_admin_mail.txt    # Admin email
├── wp_author_user.txt   # Author username
├── wp_author_pass.txt   # Author password
└── wp_author_mail.txt   # Author email
```

### Setup Steps

1. **Configure domain** in `srcs/.env`:
   ```
   DOMAIN_NAME=ribana-b.42.fr
   WP_TITLE="ribana-b Inception"
   ```

2. **Set credentials** in `secrets/` directory

3. **Build and launch**:
   ```bash
   make
   ```

## Build and Launch the Project

```bash
# Start all services (builds images if needed)
make              # or: make all

# Stop containers (preserves data volumes)
make clean

# Remove containers and volumes
make fclean

# Rebuild everything
make re
```

## Manage Containers and Volumes

```bash
# View running containers
docker compose -f srcs/docker-compose.yml ps

# View all logs
docker compose -f srcs/docker-compose.yml logs

# View specific service logs
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb

# Access container shell
docker exec -it nginx /bin/bash
docker exec -it wp /bin/bash
docker exec -it mariadb /bin/bash

# View volumes
docker volume ls

# Inspect a volume
docker volume inspect inception_wp_data
docker volume inspect inception_wp_files

# Remove unused volumes
docker volume prune
```

## Data Storage and Persistence

Named volumes are used for persistent storage:

| Volume | Description | Mount Point in Container |
|--------|-------------|-------------------------|
| `wp_data` | MariaDB database | `/var/lib/mysql` |
| `wp_files` | WordPress files | `/var/www/html` |

Data persists across container restarts and is only removed when running `make fclean`.

## Project Structure

```
inception/
├── Makefile                    # Build and deployment commands
├── srcs/
│   ├── .env                    # Environment variables
│   ├── docker-compose.yml      # Container orchestration
│   └── requirements/
│       ├── nginx/              # NGINX web server
│       │   ├── Dockerfile
│       │   ├── conf/default    # Server configuration
│       │   └── tools/script.sh
│       ├── wordpress/          # WordPress + php-fpm
│       │   ├── Dockerfile
│       │   ├── conf/www.conf   # PHP-FPM config
│       │   └── tools/setup.sh
│       └── mariadb/            # MariaDB database
│           ├── Dockerfile
│           ├── conf/50-server.cnf
│           └── tools/setup.sh
└── secrets/                    # Confidential credentials
```

## Network

All services communicate via the `inception` bridge network:

- **NGINX** (port 443) → **WordPress** (port 9000 via FastCGI)
- **WordPress** → **MariaDB** (port 3306)

## SSL/TLS

NGINX generates a self-signed certificate on startup:
- Certificate: `/etc/ssl/certs/inception.pem`
- Private key: `/etc/ssl/private/inception.key`

For production, replace with a proper certificate from a CA.
