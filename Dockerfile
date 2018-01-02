FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk add --update --no-cache openssl certbot && \
    mkdir -p /etc/nginx/ssl/live/scrapers.doctorpricer.co.nz && \
    chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]

VOLUME ["/socks"]