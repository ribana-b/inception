FROM debian:12

RUN apt update && apt install -y nginx openssl\
	&& apt clean && rm -rf /var/lib/lists/*

COPY ./conf/default /etc/nginx/sites-available
COPY --chmod=700 ./tools/script.sh /root/script.sh

EXPOSE 80 443

ENTRYPOINT ["/root/script.sh"]
CMD ["nginx", "-g", "daemon off;"]
