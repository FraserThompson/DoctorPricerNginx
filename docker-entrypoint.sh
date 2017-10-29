#! /bin/sh

cd /etc/nginx/ssl
PASS=$(openssl rand -base64 12)

openssl genrsa -des3 -passout pass:${PASS}  -out server.pass.key 2048
openssl rsa -passin pass:${PASS} -in server.pass.key -out doctorpricer.co.nz.key

rm server.pass.key

openssl req -new -key doctorpricer.co.nz.key -out doctorpricer.co.nz.csr -subj "/C=NZ/ST=Otago/L=Dunedin/O=doctorpricer.co.nz/OU=IT Department/CN=*.doctorpricer.co.nz"
openssl x509 -req -days 365 -in doctorpricer.co.nz.csr -signkey doctorpricer.co.nz.key -out doctorpricer.co.nz.crt

exec "$@"