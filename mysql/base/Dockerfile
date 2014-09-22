FROM vubui/ubuntu:latest
MAINTAINER Vu Bui

VOLUME ["/data", "/logs"]

RUN \
  echo "mysql-server mysql-server/root_password password root" | debconf-set-selections && \
  echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections

EXPOSE 3306

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld_safe"]

