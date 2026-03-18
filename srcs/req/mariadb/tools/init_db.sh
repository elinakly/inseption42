#!/bin/bash

ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"
DB_PASSWORD="$(cat /run/secrets/db_password)"

: "${MYSQL_DATABASE:?MYSQL_DATABASE is required}"
: "${MYSQL_USER:?MYSQL_USER is required}"

# Start MariaDB temporarily in background
mysqld_safe --skip-networking &
PID="$!"

# Wait until MariaDB is ready (first start may allow socket auth without password)
until mysqladmin ping -uroot --silent >/dev/null 2>&1 || \
      mysqladmin ping -uroot -p"$ROOT_PASSWORD" --silent >/dev/null 2>&1; do
    sleep 2
done

if mysql -uroot -e "SELECT 1" >/dev/null 2>&1; then
    MYSQL_AUTH=(-uroot)
else
    MYSQL_AUTH=(-uroot "-p${ROOT_PASSWORD}")
fi

# Initialize DB and app user
mysql "${MYSQL_AUTH[@]}" <<-EOSQL
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
ALTER USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

# Ensure root password is set
mysql "${MYSQL_AUTH[@]}" <<-EOSQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOSQL

echo "Database initialized"

# Stop temporary MariaDB instance
mysqladmin -uroot -p"$ROOT_PASSWORD" shutdown
wait "$PID"

# Start MariaDB as PID 1
exec mysqld --user=mysql --bind-address=0.0.0.0