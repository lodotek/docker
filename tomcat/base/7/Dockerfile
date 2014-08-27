FROM vubui/oracle-java:8
MAINTAINER Vu Bui

RUN \
  apt-get install -y tomcat7 libtcnative-1

EXPOSE 8080

WORKDIR /var/lib/tomcat7
RUN \
  sed -i '/<!--$/{N;N;s/.*\n\(.*AprLifecycleListener.*\)\n.*/\1/}' conf/server.xml && \
  mkdir /tmp/tomcat7 && \
  ln -s /tmp/tomcat7 temp && \
  echo CATALINA_BASE=`pwd` >> /usr/share/tomcat7/bin/setenv.sh && \
  echo JAVA_OPTS=-Djava.library.path=/usr/lib/x86_64-linux-gnu >> /usr/share/tomcat7/bin/setenv.sh

CMD /usr/share/tomcat7/bin/catalina.sh run

