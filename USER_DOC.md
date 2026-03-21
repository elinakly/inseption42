# User Documentation

## Overview
This stack provides a simple web service including:
- **Website**: served by Nginx + PHP-FPM  
- **Database**: MariaDB  
- **Admin Panel**: WordPress admin interface  

---

## Starting and Stopping the Project

### Start
From the project root:
```bash
make
```

This will:

1. Create required directories for data
2. Build Docker images
3. Start containers in detached mode
   
Stop
```bash
make down
```
1. Stops all running containers for the project.

Rebuild from scratch
```bash
make re
```
1. Stops, rebuilds, and restarts all services.

### Accessing Services
Website: open http://eklymova.42.fr in a browser
WordPress Admin: http://eklymova.42.fr/wp-admin
#### Credentials
Database passwords are stored in Docker secrets:
- /run/secrets/db_root_password
- /run/secrets/db_password
Only root and admin have access credentials.
- Credentials can also be viewed in .env if configured (not recommended for production).
#### Checking Services
Verify containers are running:
```bash
docker ps
```
Check logs:
```bash
docker logs <container_name>
```
Test database connection:
```bash
docker exec -it <mariadb_container> mysql -uroot -p
```
