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
  sed -i 's/\(bind-address\)/#\1/' /etc/mysql/*.cnf /etc/mysql/*/*.cnf
  
  service mysql start
  mysql --password='root' < "$MYSQL_INIT_SCRIPT"
  service mysql stop
fi

exec "$@"

