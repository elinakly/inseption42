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
RUN openssl req -newkey rsa:4096 -x509 -sha256 -nodes \
	-out /etc/nginx/ssl/tls_certificate.crt \
	-keyout /etc/nginx/ssl/tls_certificate.key \
	-subj "/C=NL/ST=NH/L=Amsterdam/O=42/OU=CODAM/CN=eklymova.42.fr" \
	-addext "subjectAltName=DNS:localhost,IP:127.0.0.1,DNS:eklymova.42.fr" \
	-addext "keyUsage=digitalSignature,keyEncipherment" \
	-addext "extendedKeyUsage=serverAuth"


# Copy NGINX configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose HTTPS port
EXPOSE 443

# Run NGINX as main process (PID 1)
CMD ["nginx", "-g", "daemon off;"]
