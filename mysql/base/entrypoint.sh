#!/bin/bash

MYSQL_CONF='/conf'
MYSQL_DATA='/data'
MYSQL_LOGS='/logs'
MYSQL_CONFIGURED="$MYSQL_CONF/configured"
MYSQL_INIT_SCRIPT="$MYSQL_DATA/mysql-init.sql"

link() {
  if [ ! -L $2 ]; then
    if [ ! "$(ls -A $1)" ]; then
      mv $2/* $1/
    fi

    rm -r $2
    ln -s $1 $2
    chown -R mysql:mysql $1 $2
  fi
}

link $MYSQL_CONF /etc/mysql
link $MYSQL_DATA /var/lib/mysql
link $MYSQL_LOGS /var/log/mysql

if [ ! -f $MYSQL_CONFIGURED ]; then
  MYSQL_CONF_FILE="$MYSQL_CONF/mysql.conf.d/mysqld.cnf"
  if [ ! -f $MYSQL_CONF_FILE ]; then
    MYSQL_CONF_FILE="$MYSQL_CONF/my.cnf"
  fi
  sed -i 's/\(bind-address\)/#\1/' $MYSQL_CONF_FILE
  sed -i '/\[mysqld\]/askip_name_resolve' $MYSQL_CONF_FILE
  touch $MYSQL_CONFIGURED
fi

if [ ! -f $MYSQL_INIT_SCRIPT ]; then
  if  [ -z $MYSQL_ROOT_PASSWORD ]; then
    export MYSQL_ROOT_PASSWORD=root
  fi

  cat > $MYSQL_INIT_SCRIPT \
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

