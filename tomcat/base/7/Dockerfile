FROM vubui/oracle-java:8
MAINTAINER Vu Bui

VOLUME /var/lib/tomcat7/webapps

RUN apt-get install -y tomcat7 libtcnative-1

EXPOSE 8080

WORKDIR /var/lib/tomcat7
RUN \
  sed -i 's/\(Server\) port="[0-9]\{4\}"/\1/' conf/server.xml && \
  sed -i '/<!--$/{N;N;s/.*\n\(.*AprLifecycleListener.*\)\n.*/\1/}' conf/server.xml && \
  mkdir /tmp/tomcat7 && \
  ln -s /tmp/tomcat7 temp && \
  echo CATALINA_BASE=`pwd` >> /usr/share/tomcat7/bin/setenv.sh && \
  echo "export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu" >> /usr/share/tomcat7/bin/setenv.sh

CMD /usr/share/tomcat7/bin/catalina.sh run

