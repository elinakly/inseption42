FROM debian:12.2
WORKDIR /inseption42

# Install the application dependencies
# Update the sistem and install nginx and opensssl
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# create ssl directory
RUN mkdir -p /etc/nginx/ssl

# generate self-signed certificate
RUN openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 \
-keyout /etc/nginx/ssl/tls.key \
-out /etc/nginx/ssl/tls.crt \
-subj "/C=NL/ST=Holland/L=Amsterdam/O=42/OU=student/CN=eklymova.42.fr"

# copy nginx config
COPY conf/nginx.conf /etc/nginx/nginx.conf

# open port 443 for HTTPS
EXPOSE 443

# Run NGINX as main process (PID 1)
CMD ["nginx", "-g", "daemon off;"]
