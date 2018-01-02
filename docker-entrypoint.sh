#! /bin/sh

if [ "$ENV" == "staging"]; then

    cd /etc/nginx/ssl/live/scrapers.doctorpricer.co.nz
    PASS=$(openssl rand -base64 12)

    openssl genrsa -des3 -passout pass:${PASS}  -out server.pass.key 2048
    openssl rsa -passin pass:${PASS} -in server.pass.key -out privkey.pem

    rm server.pass.key

    openssl req -new -key privkey.pem -out doctorpricer.co.nz.csr -subj "/C=NZ/ST=Otago/L=Dunedin/O=doctorpricer.co.nz/OU=IT Department/CN=*.doctorpricer.co.nz"
    openssl x509 -req -days 365 -in doctorpricer.co.nz.csr -signkey privkey.pem -out fullchain.pem

else 

    if [ ! -d /etc/letsencrypt/live/scrapers.doctorpricer.co.nz ]; then
        /usr/bin/certbot certonly --non-interactive --agree-tos --email doctorpricernz@gmail.com --standalone -d scrapers.doctorpricer.co.nz
    fi

fi

exec "$@"