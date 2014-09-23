#!/bin/bash

APP_ROOT=/app

(cd $APP_ROOT/OpenZIS/ZIT_SERVER && mv htaccess.txt .htaccess)
(cd $APP_ROOT/OpenZIS/ADMIN_SERVER && mv htaccess.txt .htaccess)

cat <<EOF >/app/OpenZIS/config.ini
[zit_config]
;Code Levels
; 3 Development
; 2 Test
; 1 Production
code.level = 3;

;Interface Options
interface.message.display = 50;

;session information
session.cookie_secure  = on;
session.name = "OPENZISADMIN";
session.use_only_cookies = on;
session.remember_me_seconds = 86400;

;vendor information
vendor.name    = OpenZIS Dev Team;
vendor.version = 2.3;
vendor.product = OPENZIS;

;database type
database  = "mysql";
dbname = "$DB_NAME";
host = "$DB_HOST";
username = "$DB_USER";
password = "$DB_PASS";
username2 = "$DB_USER2";
password2 = "$DB_PASS2";

;zone url location
zone.url.location = 2;

;application root
application.root.directory = /app/OpenZIS;
application.root.date_timezone = 'America/New_York';
EOF

if [[ "$CREATE_DATABASE" == "false" ]]; then
  touch /.mysql_database_created
fi

/init_db.sh

if [[ "$DB_HOST" != "127.0.0.1" ]]; then
  rm /etc/supervisor/conf.d/supervisord-mysqld.conf
fi

exec supervisord -n
