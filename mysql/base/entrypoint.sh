#!/bin/bash

MYSQL_CONF='/conf'
MYSQL_DATA='/data'
MYSQL_LOGS='/logs'
MYSQL_INIT_SCRIPT="$MYSQL_DATA/mysql-init.sql"

if [ ! "$(ls -A $MYSQL_CONF)" ]; then
  mv /etc/mysql/* /conf
  rm -r /etc/mysql
  ln -s $MYSQL_CONF /etc/mysql
  if [ ! "$(ls -A $MYSQL_DATA)" ]; then
    mv /var/lib/mysql/* $MYSQL_DATA/
    mv /var/log/mysql/* $MYSQL_LOGS/
  fi
  rm -r /var/lib/mysql /var/log/mysql
  ln -s $MYSQL_DATA /var/lib/mysql
  ln -s $MYSQL_LOGS /var/log/mysql
  chown -R mysql:mysql $MYSQL_CONF $MYSQL_DATA $MYSQL_LOGS /etc/mysql /var/lib/mysql /var/log/mysql

  MYSQL_CONF_FILE="$MYSQL_CONF/mysql.conf.d/mysqld.cnf"
  if [ ! -f $MYSQL_CONF_FILE ]; then
    MYSQL_CONF_FILE="$MYSQL_CONF/my.cnf"
  fi
  sed -i 's/\(bind-address\)/#\1/' $MYSQL_CONF_FILE
  sed -i '/\[mysqld\]/askip_name_resolve' $MYSQL_CONF_FILE
fi

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

  service mysql start
  mysql --password='root' < "$MYSQL_INIT_SCRIPT"
  service mysql stop
fi

exec "$@"

