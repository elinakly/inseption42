FROM debian:12.2

# Install MariaDB server
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*


# Copy mariadb configuration
COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/init_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_db.sh
ENTRYPOINT ["/usr/local/bin/init_db.sh"]

EXPOSE 3306
