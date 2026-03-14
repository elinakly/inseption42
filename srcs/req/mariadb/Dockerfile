FROM debian:12.2

# Install PHP and dependencies
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*


EXPOSE 3306

# Run PHP-FPM as main process
CMD ["mysqld"]