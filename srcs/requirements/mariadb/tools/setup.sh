#!/usr/bin/env bash

DB_NAME="$(cat /run/secrets/db_name)"
DB_USER_NAME="$(cat /run/secrets/db_user_name)"
DB_USER_PASS="$(cat /run/secrets/db_user_pass)"

[ ! -d "/var/lib/mysql/mysql" ] && mariadb-install-db --user=mysql --datadir=/var/lib/mysql

mariadbd --skip-networking --user=mysql &
pid="$!"

until mariadb-admin ping --silent; do
	sleep 1
done

mariadb -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS '$DB_USER_NAME'@'%' IDENTIFIED BY '$DB_USER_PASS';"
mariadb -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER_NAME'@'%';"
mariadb -e "FLUSH PRIVILEGES;"

kill "$pid"
wait "$pid"

exec "$@"
