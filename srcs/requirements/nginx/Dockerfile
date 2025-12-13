FROM debian:12

RUN apt update && apt install -y nginx \
	&& apt clean && rm -rf /var/lib/lists/*

COPY default /etc/nginx/sites-available

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
