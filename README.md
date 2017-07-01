# DoctorPricer NGINX

Simple container which takes the standard NGINX Alpine image and just chucks a config in there. Real simple, means I don't have to mess with volumes (except for SSL).

Expects `doctorpricer.co.nz.crt` and `doctorpricer.co.nz.key` to exist at /etc/nginx/ssl