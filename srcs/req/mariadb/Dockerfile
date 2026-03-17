FROM debian:12.2

# Install MariaDB server
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*



COPY ./tools/init_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_db.sh
ENTRYPOINT ["/usr/local/bin/init_db.sh"]

EXPOSE 3306

# Run MariaDB server as main process
CMD ["mysqld", "--user=mysql"]