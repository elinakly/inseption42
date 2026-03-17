FROM debian:12.2
WORKDIR /var/www/html

# Install PHP and dependencies
RUN apt-get update && apt-get install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#     && chmod +x /usr/local/bin/wp

# Download and extract WordPress
RUN wget https://wordpress.org/wordpress-6.5.2.tar.gz \
    && tar -xzf wordpress-6.5.2.tar.gz --strip-components=1 \
    && rm wordpress-6.5.2.tar.gz

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY ./tools/setup_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_wp.sh
ENTRYPOINT ["/usr/local/bin/setup_wp.sh"]


EXPOSE 9000

# Run PHP-FPM as main process
CMD ["php-fpm8.2", "-F"]