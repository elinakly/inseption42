*This project has been created as part of the 42 curriculum by eklymova.*

# Inception Project

## Description
Inception is a project that focuses on container orchestration using Docker to simulate a small production environment.  
The goal is to build a multi-container setup including Nginx, PHP-FPM, and MariaDB, with proper networking, volumes, and secrets management.  
This project also emphasizes best practices in security, modular design, and automation using Docker and bash scripts.

---

## Instructions

### Prerequisites
- Docker ≥ 20.10
- Docker Compose (plugin or standalone)
- Make

### Running the project
1. Clone the repository:
```bash
git clone <repo_url>
cd inception42
```
Build and start containers using Make:
```bash
make
```
This will:
  create required directories (/data/mariadb, /data/wordpress)
  build images using docker-compose.yml
  start containers in detached mode
Stop containers:
```bash
make down
```
Rebuild everything from scratch:
```bash
make re
```
### Notes
- Database credentials are stored in Docker secrets (/run/secrets/...)

- Custom initialization scripts handle creating databases, users, and setting passwords

- Logs can be accessed via Docker logs or mapped volumes

### Project Design Choices
#### Use of Docker
- Containers are used instead of full VMs for lightweight, reproducible environments
- Services (Nginx, PHP, MariaDB) are isolated yet networked together
- Initialization scripts allow automated setup with secrets
#### Source Files
- srcs/ contains Dockerfiles, docker-compose.yml, and initialization scripts
- Bash scripts automate DB setup and service startup
- Comparisons
### Concept	Choice	Reason
1. Virtual Machines vs Docker	Docker	Faster startup, lightweight, easier networking, easier cleanup
2. Secrets vs Environment Variables	Docker Secrets	Secure storage of passwords; environment variables are exposed in process list
3. Docker Network vs Host Network	Docker Network (bridge)	Container isolation, prevents host port conflicts, secure internal communication
4. Docker Volumes vs Bind Mounts	Volumes	Managed by Docker, safe for persistence, easier backup and migration; bind mounts used only for code sharing during development
### Resources
1. Docker documentation: https://docs.docker.com/
2. Docker Compose: https://docs.docker.com/compose/
3. MariaDB documentation: https://mariadb.com/kb/en/documentation/
4. Nginx documentation: https://nginx.org/en/docs/
AI usage: AI was used to review bash scripts, suggest improvements in Docker Compose structure, and optimize Makefile logic.
#### Additional Information
All containers are built to run as non-root users where possible.  
Logs and persistent data are stored in volumes for security and durability.  
Networking allows containers to communicate internally while exposing only necessary ports to host.  
