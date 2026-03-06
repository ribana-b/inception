# User Documentation

## Services Provided by the Stack

This project provides a WordPress deployment with the following services:

- **NGINX**: Web server with SSL/TLS (port 443 only, TLSv1.2/TLSv1.3)
- **WordPress + php-fpm**: Content Management System (handles PHP processing)
- **MariaDB**: Database for WordPress (stores all data)

## Start and Stop the Project

```bash
# Start the project (builds images and launches containers)
make

# Stop containers (preserves data)
make clean

# Stop and remove all data (volumes)
make fclean

# Rebuild and start from scratch
make re
```

## Access the Website and Administration Panel

- **Website**: https://ribana-b.42.fr (or https://ribana-b.42malaga.com)
- **WordPress Admin Panel**: https://ribana-b.42.fr/wp-admin/
- **HTTPS Only**: Port 443 with TLSv1.2/TLSv1.3

## Locate and Manage Credentials

Credentials are stored in the `secrets/` directory:

| File | Description |
|------|-------------|
| `db_name.txt` | Database name |
| `db_user_name.txt` | Database username |
| `db_user_pass.txt` | Database password |
| `wp_admin_user.txt` | WordPress admin username |
| `wp_admin_pass.txt` | WordPress admin password |
| `wp_admin_mail.txt` | WordPress admin email |
| `wp_author_user.txt` | WordPress author username |
| `wp_author_pass.txt` | WordPress author password |
| `wp_author_mail.txt` | WordPress author email |

To update credentials, modify these files and rebuild the project.

## Check That Services Are Running Correctly

```bash
# List running containers
docker compose -f srcs/docker-compose.yml ps

# View all logs
docker compose -f srcs/docker-compose.yml logs

# View specific service logs
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb

# Check if a specific service is healthy
docker compose -f srcs/docker-compose.yml ps | grep nginx
docker compose -f srcs/docker-compose.yml ps | grep wordpress
docker compose -f srcs/docker-compose.yml ps | grep mariadb
```
