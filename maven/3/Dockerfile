FROM vubui/oracle-java:8
MAINTAINER Vu Bui

VOLUME ["/src", "/.m2"]

ENV MAVEN_MAJOR 3
ENV MAVEN_VERSION 3.3.3

RUN \
  wget http://www.us.apache.org/dist/maven/maven-$MAVEN_MAJOR/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -xzf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/local && \
  mv /usr/local/apache-maven-$MAVEN_VERSION /usr/local/maven && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  ln -s /usr/local/maven/bin/mvn /usr/local/bin/mvn && \
  ln -s /usr/local/maven/bin/mvnDebug /usr/local/bin/mvnDebug && \
  ln -s /.m2 ~/.m2

WORKDIR /src

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

