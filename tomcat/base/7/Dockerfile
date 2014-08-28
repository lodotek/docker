FROM vubui/oracle-java:8
MAINTAINER Vu Bui

VOLUME ["/webapps", "/logs"]

RUN apt-get install -y tomcat7 libtcnative-1

WORKDIR /var/lib/tomcat7
RUN \
  sed -i 's/\(appBase=\)"[^"]*"/\1"\/webapps"/' conf/server.xml && \
  sed -i 's/\(Server\) port="[0-9]\{4\}"/\1/' conf/server.xml && \
  sed -i '/<!--$/{N;/AprLifecycleListener/{N;s/.*\n\(.*\)\n.*/\1/}}' conf/server.xml && \
  rm logs && \
  ln -s /logs logs && \
  mkdir /tmp/tomcat7 && \
  ln -s /tmp/tomcat7 temp && \
  echo CATALINA_BASE=`pwd` >> /usr/share/tomcat7/bin/setenv.sh && \
  echo "export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu" >> /usr/share/tomcat7/bin/setenv.sh

EXPOSE 8080

CMD ["/usr/share/tomcat7/bin/catalina.sh", "run"]

