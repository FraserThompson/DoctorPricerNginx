FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY usrlocalbin /usr/local/bin

RUN apk add --update --no-cache openssl certbot && \
    chmod +x /docker-entrypoint.sh && \
    chmod +x /usr/local/bin/certbot-get

RUN set -x \
	&& addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]

VOLUME ["/socks"]