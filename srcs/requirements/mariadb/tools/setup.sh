#!/bin/bash

DB_NAME="$(cat /run/secrets/db_name)"
DB_USER_NAME="$(cat /run/secrets/db_user_name)"
DB_USER_PASS="$(cat /run/secrets/db_user_pass)"

mariadb -e "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS '$DATABASE_USER_NAME'@'%' IDENTIFIED BY '$DATABASE_USER_PASSWORD';"
mariadb -e "GRANT ALL ON $DATABASE_NAME.* TO '$DATABASE_USER_NAME'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
