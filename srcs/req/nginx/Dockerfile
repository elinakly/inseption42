FROM debian:12.2
WORKDIR /inseption42

# Update package lists and install NGINX + OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Create SSL certificate directory
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed TLS certificate
RUN openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 \
-keyout /etc/nginx/ssl/tls.key \
-out /etc/nginx/ssl/tls.crt \

####LEARN
-subj "/C=NL/ST=Holland/L=Amsterdam/O=42/OU=student/CN=eklymova.42.fr" \
-addext "subjectAltName=DNS:eklymova.42.fr" \
-addext "keyUsage=digitalSignature,keyEncipherment" \
-addext "extendedKeyUsage=serverAuth"

# Copy NGINX configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose HTTPS port
EXPOSE 443

# Run NGINX as main process (PID 1)
CMD ["nginx", "-g", "daemon off;"]
