FROM debian:12

RUN apt update && apt install -y mariadb-server \
	&& apt clean && rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /var/lib/mysql /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d
COPY --chmod=700 ./tools/setup.sh /root/setup.sh

EXPOSE 3306

ENTRYPOINT ["/root/setup.sh"]
CMD ["mysqld_safe"]
