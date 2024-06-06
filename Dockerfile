FROM alpine:latest
ENV MYSQL_ROOT_PASSWORD=Aa12345678
RUN apk update && \
    apk add --no-cache mysql redis && \
    rm -rf /var/cache/apk/* && \
    sed -i "s/protected-mode yes/protected-mode no/" /etc/redis.conf && \
    sed -i "s/bind 127.0.0.1 -::1/bind 0.0.0.0/" /etc/redis.conf && \
    sed -i "s/# requirepass foobared/requirepass Aa12345678/" /etc/redis.conf && \
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Aa12345678' WITH GRANT OPTION;" > /etc/my.cnf.d/init.sql && \
    echo "FLUSH PRIVILEGES;" >> /etc/my.cnf.d/init.sql && \
    sed -i "s|skip-networking|init-file=/etc/my.cnf.d/init.sql|" /etc/my.cnf.d/mariadb-server.cnf && \   
    sed -i "s/#bind-address=0.0.0.0/bind-address=0.0.0.0/" /etc/my.cnf.d/mariadb-server.cnf && \     
    mysql_install_db --user=root --datadir=/var/lib/mysql && \
    mkdir -p /run/mysqld/
EXPOSE 3306 6379
CMD redis-server /etc/redis.conf & mysqld --user=root && wait
