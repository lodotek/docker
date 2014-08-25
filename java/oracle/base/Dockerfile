FROM ubuntu:latest
MAINTAINER Vu Bui

RUN \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu `lsb_release -cs` main" \
    >> /etc/apt/sources.list.d/webupd8team-java.list && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu `lsb_release -cs` main" \
    >> /etc/apt/sources.list.d/webupd8team-java.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \

  echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

