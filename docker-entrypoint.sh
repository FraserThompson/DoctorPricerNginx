#! /bin/sh

chown -R www-data:varwwwusers /var/www/dp_server/assets

if [ "$ENV" == "dev" ]; then

    mkdir -p /etc/letsencrypt/live/api2.doctorpricer.co.nz
    cd /etc/letsencrypt/live/api2.doctorpricer.co.nz
    PASS=$(openssl rand -base64 12)

    openssl genrsa -des3 -passout pass:${PASS}  -out server.pass.key 2048
    openssl rsa -passin pass:${PASS} -in server.pass.key -out privkey.pem

    rm server.pass.key

    openssl req -new -key privkey.pem -out doctorpricer.co.nz.csr -subj "/C=NZ/ST=Otago/L=Dunedin/O=doctorpricer.co.nz/OU=IT Department/CN=*.doctorpricer.co.nz"
    openssl x509 -req -days 365 -in doctorpricer.co.nz.csr -signkey privkey.pem -out fullchain.pem

else 

    if [ ! -f /etc/letsencrypt/live/api2.doctorpricer.co.nz/fullchain.pem ]; then
        certbot-get
    fi

fi

exec "$@"