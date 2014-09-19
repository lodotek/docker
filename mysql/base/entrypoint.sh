#!/bin/bash

service mysql start

MYSQL_INIT_SCRIPT=/tmp/mysql-init.sql

if [ ! -f $MYSQL_INIT_SCRIPT ]; then
  if  [ -z $MYSQL_ROOT_PASSWORD ]; then
    export MYSQL_ROOT_PASSWORD=root
  fi

  cat > $MYSQL_INIT_SCRIPT \
<<-EOSQL
DELETE FROM mysql.user;
FLUSH PRIVILEGES;
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS test;
EOSQL

  mysql --user=root --password=root < $MYSQL_INIT_SCRIPT
fi

if [ -n $1 ] && [ -x $1 ]; then
  exec "$@"
else
  exec tail -f /var/log/mysql/error.log
fi

