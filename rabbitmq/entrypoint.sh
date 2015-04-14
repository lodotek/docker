#!/bin/bash

RABBITMQ_CONF='/conf'

if [ ! -f "$RABBITMQ_CONF/enabled_plugins" ]; then
  if  [ -z $RABBITMQ_PLUGINS ]; then
    export RABBITMQ_PLUGINS='[rabbitmq_management_visualiser,rabbitmq_stomp].'
  fi

  echo $RABBITMQ_PLUGINS > $RABBITMQ_CONF/enabled_plugins
fi

if [ ! -f "$RABBITMQ_CONF/rabbitmq.config" ]; then
  echo '[{rabbit, [{loopback_users, []}]}].' > $RABBITMQ_CONF/rabbitmq.config
fi

exec "$@"

