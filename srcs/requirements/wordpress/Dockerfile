FROM debian:12

RUN apt update && apt install -y php8.2-fpm

COPY www.conf /etc/php/8.2/fpm/pool.d

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]
