FROM vubui/erlang:latest
MAINTAINER Vu Bui

VOLUME ["/etc/rabbitmq", "/var/lib/rabbitmq", "/var/log/rabbitmq"]

ENV RABBITMQ_VERSION 3.5.1

RUN \
  wget https://www.rabbitmq.com/releases/rabbitmq-server/v$RABBITMQ_VERSION/rabbitmq-server-generic-unix-$RABBITMQ_VERSION.tar.gz && \
  tar -xzf rabbitmq-server-generic-unix-$RABBITMQ_VERSION.tar.gz -C /usr/local && \
  mv /usr/local/rabbitmq_server-$RABBITMQ_VERSION /usr/local/rabbitmq && \
  rm rabbitmq-server-generic-unix-$RABBITMQ_VERSION.tar.gz && \
  ln -s /usr/local/rabbitmq/sbin/* /usr/local/bin/ && \
  mv /usr/local/rabbitmq/etc/rabbitmq/* /etc/rabbitmq/ && \
  rm -r /usr/local/rabbitmq/etc/rabbitmq && \
  ln -s /etc/rabbitmq /usr/local/rabbitmq/etc/rabbitmq && \
  mkdir -p /usr/local/rabbitmq/var/log /usr/local/rabbitmq/var/lib && \
  ln -s /var/lib/rabbitmq /usr/local/rabbitmq/var/lib/rabbitmq && \
  ln -s /var/log/rabbitmq /usr/local/rabbitmq/var/log/rabbitmq

EXPOSE 5672 61613 15672

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

