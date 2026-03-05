#!/usr/bin/env bash

set -x

if [ ! -f wp-config.php ]; then
	DB_NAME="$(cat /run/secrets/db_name)"
	DB_USER_NAME="$(cat /run/secrets/db_user_name)"
	DB_USER_PASS="$(cat /run/secrets/db_user_pass)"
	WP_ADMIN_USER="$(cat /run/secrets/wp_admin_user)"
	WP_ADMIN_PASS="$(cat /run/secrets/wp_admin_pass)"
	WP_ADMIN_MAIL="$(cat /run/secrets/wp_admin_mail)"
	WP_USER="$(cat /run/secrets/wp_author_user)"
	WP_PASS="$(cat /run/secrets/wp_author_pass)"
	WP_MAIL="$(cat /run/secrets/wp_author_mail)"

	curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x /usr/local/bin/wp

	wp core download --allow-root
	wp config create --allow-root --dbname="$DB_NAME" --dbuser="$DB_USER_NAME" --dbpass="$DB_USER_PASS" --dbhost=mariadb
	wp core install --allow-root --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_email="$WP_ADMIN_MAIL" --skip-email
	wp user create --allow-root "$WP_USER" "$WP_MAIL" --role=author --user_pass="$WP_PASS"
fi

exec "$@"
