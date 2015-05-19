FROM vubui/oracle-java:8
MAINTAINER Vu Bui

VOLUME ["/data", "/logs"]

RUN \
  wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war && \
  mv /usr/local/apache-maven-$MAVEN_VERSION /usr/local/maven && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  ln -s /usr/local/maven/bin/mvn /usr/local/bin/mvn && \
  ln -s /usr/local/maven/bin/mvnDebug /usr/local/bin/mvnDebug && \
  ln -s /.m2 ~/.m2

EXPOSE 8080 50000

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

