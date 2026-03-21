## **DEV_DOC.md**

```markdown id="6s3vhl"```
# Developer Documentation

## Environment Setup

### Prerequisites
- Docker ≥ 20.10
- Docker Compose (plugin or standalone)
- Make
- Git
- Optional: VS Code or another IDE for development

### Configuration
- Environment variables:
  - `MYSQL_DATABASE`, `MYSQL_USER`
- Docker secrets:
  - `db_root_password`
  - `db_password`

---

## Building and Launching

From the root directory:

```bash
make
make build → build Docker images only
make up → start services in detached mode
make down → stop services
make re → rebuild everything from scratch
```
### Managing Containers and Volumes
List running containers:
```bash
docker ps
```
Access a container shell:
```bash
docker exec -it <container_name> bash
```
Remove unused volumes:
```bash
docker volume prune
```
### Data Persistence
MariaDB and WordPress data are stored in Docker volumes:
1. MariaDB: data/mariadb
2. WordPress: data/wordpress
- Volumes persist data even after containers are removed.
3. Use docker volume inspect <volume_name> to see paths.
### Notes for Developers
- Initialization scripts automatically create databases and users.
- Bash scripts are located in srcs/.
- Docker Compose defines all service dependencies, networks, and volumes.
- Use docker-compose logs for troubleshooting.
