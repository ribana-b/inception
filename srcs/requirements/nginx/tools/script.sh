#!/usr/bin/env bash

openssl req -x509 -nodes -newkey rsa:2048 \
-keyout /etc/ssl/private/inception.key \
-out /etc/ssl/certs/inception.pem \
-days 365 \
-subj "/C=ES/ST=Malaga/L=Malaga/O=42School/OU=Inception/CN=ribana-b.42.fr"

exec "$@"
