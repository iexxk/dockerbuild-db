FROM alpine:latest
RUN apk update && \
    apk add --no-cache mysql redis && \
    rm -rf /var/cache/apk/*
EXPOSE 3306 6379
CMD rc-service mysql start && \
    rc-service redis start && \
    tail -f /dev/null
