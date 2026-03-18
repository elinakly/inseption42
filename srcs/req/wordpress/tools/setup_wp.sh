#!/bin/bash
set -e

DB_PASSWORD="$(cat /run/secrets/db_password)"
WP_ADMIN_PASSWORD="$(cat /run/secrets/wp_admin_password)"
WP_USER_PASSWORD="$(cat /run/secrets/wp_user_password)"

: "${MYSQL_DATABASE:?MYSQL_DATABASE is required}"
: "${MYSQL_USER:?MYSQL_USER is required}"
: "${WP_ADMIN_USER:?WP_ADMIN_USER is required}"
: "${WP_USER:?WP_USER is required}"
: "${DOMAIN_NAME:?DOMAIN_NAME is required}"
: "${WP_ADMIN_EMAIL:?WP_ADMIN_EMAIL is required}"
: "${WP_USER_EMAIL:?WP_USER_EMAIL is required}"
: "${WP_DB_HOST:?WP_DB_HOST is required}"

cd /var/www/html

# Wait for database to be ready
until mysqladmin ping -h"$WP_DB_HOST" -u"$MYSQL_USER" -p"$DB_PASSWORD" --silent; do
  echo "Waiting for database..."
  sleep 2
done

# Create config only once
if [ ! -f wp-config.php ]; then
  echo "Creating wp-config.php..."
  wp config create \
      --dbname="$MYSQL_DATABASE" \
      --dbuser="$MYSQL_USER" \
      --dbpass="$DB_PASSWORD" \
      --dbhost="$WP_DB_HOST" \
      --allow-root
fi

# Install WordPress only if not installed yet
if ! wp core is-installed --allow-root; then
  echo "Installing WordPress..."
  wp core install \
      --url="$DOMAIN_NAME" \
      --title="Inception" \
      --admin_user="$WP_ADMIN_USER" \
      --admin_password="$WP_ADMIN_PASSWORD" \
      --admin_email="$WP_ADMIN_EMAIL" \
      --skip-email \
      --allow-root
fi

# Create additional user if missing
if ! wp user get "$WP_USER" --allow-root >/dev/null 2>&1; then
  echo "Creating user account..."
  wp user create \
      "$WP_USER" "$WP_USER_EMAIL" \
      --user_pass="$WP_USER_PASSWORD" \
      --role=author \
      --allow-root
fi

echo "WP setup completed successfully"

# Start php-fpm
exec "$@"