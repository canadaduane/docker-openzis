VOLUME_HOME="/var/lib/mysql"

if [[ "$DB_HOST" == "127.0.0.1" ]]; then
  if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
  else
    echo "=> Using an existing volume of MySQL"
  fi
fi

if [ ! -f /.mysql_database_created ]; then
  if [[ "$DB_HOST" == "127.0.0.1" ]]; then
    echo "=> Starting MySQL Server"
    /usr/bin/mysqld_safe >/dev/null 2>&1 &
  fi

  RET=1
  while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -u "$DB_USER" --password="$DB_PASS" -e "status" > /dev/null 2>&1
    RET=$?
  done

  echo "=> Create database $1"
  echo "CREATE DATABASE $DB_NAME" | mysql -u "$DB_USER" --password="$DB_PASS"

  echo "=> Importing SQL files"
  pushd /app/OpenZIS/db/mysql
  for SQL_FILE in \
      ZISDB.sql \
      update_uk1.sql \
      update.sql \
      events.sql \
      filters.sql \
      default_groups.sql \
      default_qa.sql; do
    echo "  $SQL_FILE..."
    mysql -u "$DB_USER" --password="$DB_PASS" "$DB_NAME" < "$SQL_FILE"
  done
  popd

  if [[ "$DB_HOST" == "127.0.0.1" ]]; then
    echo "=> Closing MySQL Server (setup)"
    mysqladmin -u "$DB_USER" --password="$DB_PASS" shutdown
  fi

  touch /.mysql_database_created
fi
