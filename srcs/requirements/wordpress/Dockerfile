FROM debian:12

RUN apt update && apt install -y php8.2-fpm php-mysqli curl

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d
COPY --chmod=700 ./tools/setup.sh /root/setup.sh

EXPOSE 9000

WORKDIR /var/www/html

ENTRYPOINT ["/root/setup.sh"]
CMD ["php-fpm8.2", "-F"]
