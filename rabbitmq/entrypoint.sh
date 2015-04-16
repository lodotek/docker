#!/bin/bash

RABBITMQ_CONF='/conf'
RABBITMQ_DATA='/data'

if [ ! -f "$RABBITMQ_CONF/enabled_plugins" ]; then
  if  [ -z $RABBITMQ_PLUGINS ]; then
    export RABBITMQ_PLUGINS='[rabbitmq_management_visualiser,rabbitmq_stomp].'
  fi

  echo $RABBITMQ_PLUGINS > $RABBITMQ_CONF/enabled_plugins
fi

if [ ! -f "$RABBITMQ_CONF/rabbitmq.config" ]; then
  echo '[{rabbit, [{loopback_users, []}]}].' > $RABBITMQ_CONF/rabbitmq.config
fi

if [ ! -f "$HOME/.erlang.cookie" -a "$RABBITMQ_COOKIE" ]; then
  echo $RABBITMQ_COOKIE > $HOME/.erlang.cookie
  chmod 400 $HOME/.erlang.cookie
fi

if [ ! -d "$RABBITMQ_DATA/mnesia/rabbit@$(cat /etc/hostname)" -a "$RABBITMQ_CLUSTER_HOST" ]; then
  if [ "$RABBITMQ_CLUSTER_IP" ]; then
    echo "$RABBITMQ_CLUSTER_IP $RABBITMQ_CLUSTER_HOST" >> /etc/hosts
  fi
  rabbitmq-server -detached
  rabbitmqctl stop_app
  rabbitmqctl join_cluster rabbit@$RABBITMQ_CLUSTER_HOST
  rabbitmqctl stop
fi

exec "$@"

