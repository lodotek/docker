#!/bin/bash

if [ ! -f '/etc/rabbitmq/enabled_plugins' ]; then
  if  [ -z $RABBITMQ_PLUGINS ]; then
    export RABBITMQ_PLUGINS='[rabbitmq_management_visualiser,rabbitmq_stomp].'
  fi

  echo $RABBITMQ_PLUGINS > /etc/rabbitmq/enabled_plugins
fi

if [ ! -f '/etc/rabbitmq/rabbitmq.config' ]; then
  echo '[{rabbit, [{loopback_users, []}]}].' > /etc/rabbitmq/rabbitmq.config
fi

if [ -z $@ ]; then
  rabbitmq-server -detached
  sleep 5
  exec "tail -f /var/log/rabbitmq/rabbit\@`cat /etc/hostname`.log"
else
  exec "$@"
fi

