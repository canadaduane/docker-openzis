VOLUME_HOME="/var/lib/mysql"
DB_NAME="openzis"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
  echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
  echo "=> Installing MySQL ..."
  mysql_install_db > /dev/null 2>&1
  echo "=> Done!"
else
  echo "=> Using an existing volume of MySQL"
fi

if [ ! -f /.mysql_database_created ]; then
  echo "=> Starting MySQL Server"
  /usr/bin/mysqld_safe >/dev/null 2>&1 &

  RET=1
  while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
  done

  echo "=> Create database $1"
  echo "CREATE DATABASE $DB_NAME" | mysql -uroot

  echo "=> Importing SQL files"
  pushd /app/OpenZIS/db/mysql
  for SQL_FILE in \
      ZISDB.sql \
      update_uk1.sql \
      update.sql \
      events.sql \
      filters.sql; do
    echo "  $SQL_FILE..."
    mysql -uroot "$DB_NAME" < "$SQL_FILE"
  done
  popd

  echo "=> Closing MySQL Server (setup)"
  mysqladmin -uroot shutdown

  touch /.mysql_database_created
fi
