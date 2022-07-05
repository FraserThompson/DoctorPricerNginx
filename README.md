# DoctorPricer NGINX

Simple container which takes the standard NGINX Alpine image and just chucks a config in there. Real simple, means I don't have to mess with volumes (except for SSL).

Expects `doctorpricer.co.nz.crt` and `doctorpricer.co.nz.key` to exist at `/etc/nginx/ssl` so it self generates these on build. Obviously those shouldn't be used in production, they're mainly just to make dev stuff easier (I don't want to care about SSL when I'm devving). In production I'll overwrite these from a host volume.

## Build and push to Dockerhub

`npm run docker-push`

## My letsencrypt certificate has expired!!!

Run docker restart doctorpricer_nginx_1 and it should fix it