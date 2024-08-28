FROM armdocker.seli.gic.ericsson.se/dockerhub-ericsson-remote/nginx:1.15.12-alpine

COPY nginx/production.conf /etc/nginx/conf.d/default.conf

# Copy Version for Sharing via Volume
COPY VERSION /etc/nginx/conf.d/version-info/
