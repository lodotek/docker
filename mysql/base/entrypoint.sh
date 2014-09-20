#!/bin/bash

MYSQL_INIT_SCRIPT='/tmp/mysql-init.sql'

if [ ! -f $MYSQL_INIT_SCRIPT ]; then
  if  [ -z $MYSQL_ROOT_PASSWORD ]; then
    export MYSQL_ROOT_PASSWORD=root
  fi

  cat > "$MYSQL_INIT_SCRIPT" \
<<-EOSQL
DELETE FROM mysql.user where User <> 'debian-sys-maint';
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION;
DROP DATABASE IF EXISTS test;
EOSQL

  sed -i 's/\(bind-address\)/#\1/' /etc/mysql/my.cnf
  service mysql start
  mysql --password='root' < "$MYSQL_INIT_SCRIPT"
  service mysql stop
fi

exec "$@"

