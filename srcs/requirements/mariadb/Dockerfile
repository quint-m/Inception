FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql /var/log/mysql

# Copy configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY ./tools/init.sql /etc/mysql/init.sql
RUN chmod 644 /etc/mysql/init.sql

RUN mkdir -p /run/mysqld

COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["mysqld"]