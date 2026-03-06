*This project has been created as part of the 42 curriculum by ribana-b.*

# Inception

## Description

This project sets up a small infrastructure using Docker containers with the following services:

- **NGINX**: Web server with TLSv1.2/TLSv1.3 (port 443)
- **WordPress + php-fpm**: Content Management System
- **MariaDB**: Database for WordPress

The goal is to learn system administration by virtualizing multiple Docker images, creating a personal infrastructure with persistent data and secure communications.

## Instructions

### Quick Start

```bash
make              # Build and start all services
make clean        # Stop containers
make fclean       # Stop and remove volumes
make re           # Rebuild and restart
```

### Access

- **Website**: https://ribana-b.42.fr
- **WordPress Admin**: https://ribana-b.42malaga.com/wp-admin/

### Requirements

- Docker Engine
- Docker Compose plugin
- A virtual machine (required by the project)

### Configuration

Edit `srcs/.env` to configure the domain name:

```
DOMAIN_NAME=ribana-b.42.fr
WP_TITLE="ribana-b Inception"
```

Credentials are stored in the `secrets/` directory.

## Resources

- https://docs.docker.com/reference/dockerfile
- https://github.com/compose-spec/compose-spec/blob/main/spec.md
- https://cloud.theodo.com/en/blog/docker-processes-container
- https://medium.com/@boutnaru/the-linux-process-journey-pid-1-init-60765a069f17
- https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671
- https://github.com/cfareste/Inception
- https://www.digitalocean.com/community/tutorials/php-fpm-nginx
- https://wp-cli.org/

### AI Usage

AI was used to assist with:
- Documentation structure and formatting
- Docker Compose configuration best practices
- Explaining Docker networking and volume concepts

## Project Description

### Virtual Machines vs Docker

Virtual machines virtualize the hardware layer - each VM runs a complete OS with its own kernel. Docker containers virtualize the OS layer, sharing the host kernel. This makes containers:
- Lighter (no duplicate OS)
- Faster to start
- More efficient with resources
- Easier to package and distribute

### Secrets vs Environment Variables

Environment variables are suitable for non-sensitive configuration (domain names, ports). They are visible in the container and can leak to logs.

Docker secrets are encrypted at rest and in transit, stored in tmpfs mounts, and only accessible to authorized services. They should be used for:
- Database passwords
- API keys
- User credentials
- SSL certificates

### Docker Network vs Host Network

Host network mode removes network isolation between container and host - the container shares the host's network namespace.

Bridge network (default Docker network) creates an internal network between containers, providing:
- Service isolation
- Port mapping flexibility
- Better security
- Container-to-container communication

### Docker Volumes vs Bind Mounts

Bind mounts map a specific host directory into the container. They are useful for development but tie the container to a specific host path.

Named volumes are managed by Docker, stored in Docker's area, and offer:
- Better portability
- Easier backup/migration
- Better performance on some filesystems
- Required by the project for WordPress database and files

## Documentation

- [USER_DOC.md](USER_DOC.md) - End user guide
- [DEV_DOC.md](DEV_DOC.md) - Developer documentation
