FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

# Generate self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=NL/ST=North Holland/L=Amsterdam/O=42/CN=localhost"

# Set proper permissions for SSL files
RUN chmod 600 /etc/nginx/ssl/nginx.key && \
    chmod 644 /etc/nginx/ssl/nginx.crt

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]