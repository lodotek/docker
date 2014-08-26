FROM vubui/oracle-java:8
MAINTAINER Vu Bui

RUN \
  apt-get install -y tomcat7 libtcnative-1 && \
  sed -i "s|#\(JAVA_HOME=\).*|\1$JAVA_HOME|g" /etc/default/tomcat7 && \
  sed -i 's/\(TOMCAT7_.*=\).*/\1root/' /etc/default/tomcat7

EXPOSE 8080

CMD \
  service tomcat7 start && \
  tail -f /var/lib/tomcat7/logs/catalina.out
