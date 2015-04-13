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

  mv /var/lib/mysql/* /data/
  mv /var/log/mysql/* /logs/
  rm -r /var/lib/mysql /var/log/mysql
  ln -s /data /var/lib/mysql
  ln -s /logs /var/log/mysql
  chown mysql:mysql /data /logs /var/lib/mysql /var/log/mysql

  MYSQL_CONF_FILE='/etc/mysql/mysql.conf.d/mysqld.cnf'
  if [ ! -f $MYSQL_CONF_FILE ]; then
    MYSQL_CONF_FILE='/etc/mysql/my.cnf'
  fi
  sed -i 's/\(bind-address\)/#\1/' $MYSQL_CONF_FILE
  sed -i '/\[mysqld\]/askip_name_resolve' $MYSQL_CONF_FILE

  service mysql start
  mysql --password='root' < "$MYSQL_INIT_SCRIPT"
  service mysql stop
fi

exec "$@"

