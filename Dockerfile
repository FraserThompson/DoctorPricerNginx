FROM nginx:1.23.0-alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk add --update --no-cache openssl certbot && \
    chmod +x /docker-entrypoint.sh

RUN set -x \
    && deluser xfs \
	&& addgroup -g 1000 -S varwwwusers \
	&& adduser -u 33 -D -S -G varwwwusers www-data

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]

VOLUME ["/socks"]