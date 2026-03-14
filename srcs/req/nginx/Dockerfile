FROM debian:12.2
WORKDIR /inseption42

# Install the application dependencies
# Update the sistem and install nginx and opensssl
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Copy conf nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# COpy sertificate TLS
COPY conf/ssl /etc/ssl

# open port 443 for HTTPS
EXPOSE 443

# Run NGINX as main process (PID 1)
CMD ["nginx", "-g", "daemon off;"]