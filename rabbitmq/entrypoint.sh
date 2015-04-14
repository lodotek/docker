#!/bin/bash

CONF_LOC='/conf'

if [ ! -f "$CONF_LOC/enabled_plugins" ]; then
  if  [ -z $RABBITMQ_PLUGINS ]; then
    export RABBITMQ_PLUGINS='[rabbitmq_management_visualiser,rabbitmq_stomp].'
  fi

  echo $RABBITMQ_PLUGINS > $CONF_LOC/enabled_plugins
fi

if [ ! -f "$CONF_LOC/rabbitmq.config" ]; then
  echo '[{rabbit, [{loopback_users, []}]}].' > $CONF_LOC/rabbitmq.config
fi

exec "$@"

