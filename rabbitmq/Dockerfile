FROM vubui/erlang:17
MAINTAINER Vu Bui

VOLUME ["/etc/rabbitmq", "/var/lib/rabbitmq", "/var/log/rabbitmq"]

ENV RABBITMQ_VERSION 3.5.1

RUN \
  wget https://www.rabbitmq.com/releases/rabbitmq-server/v$RABBITMQ_VERSION/rabbitmq-server-generic-unix-$RABBITMQ_VERSION.tar.gz && \
  tar -xzf rabbitmq-server-generic-unix-$RABBITMQ_VERSION.tar.gz -C /usr/local && \
  mv /usr/local/rabbitmq_server-$RABBITMQ_VERSION /usr/local/rabbitmq && \
  rm rabbitmq-server-generic-unix-$RABBITMQ_VERSION.tar.gz && \
  ln -s /usr/local/rabbitmq/sbin/rabbitmq-server /usr/local/bin/rabbitmq-server && \
  ln -s /usr/local/rabbitmq/sbin/rabbitmqctl /usr/local/bin/rabbitmqctl && \
  ln -s /usr/local/rabbitmq/sbin/rabbitmq-plugins /usr/local/bin/rabbitmq-plugins && \
  mv /usr/local/rabbitmq/etc/rabbitmq/* /etc/rabbitmq/ && \
  rm -r /usr/local/rabbitmq/etc/rabbitmq && \
  ln -s /etc/rabbitmq /usr/local/rabbitmq/etc/rabbitmq && \
  mkdir -p /usr/local/rabbitmq/var/log /usr/local/rabbitmq/var/lib && \
  ln -s /var/lib/rabbitmq /usr/local/rabbitmq/var/lib/rabbitmq && \
  ln -s /var/log/rabbitmq /usr/local/rabbitmq/var/log/rabbitmq && \
  rabbitmq-plugins enable --offline rabbitmq_stomp && \
  rabbitmq-plugins enable --offline rabbitmq_management && \
  rabbitmq-plugins enable --offline rabbitmq_management_visualiser

EXPOSE 5672 61613 15672

CMD ["rabbitmq-server"]

