FROM ubuntu:18.04

RUN bash -c "echo 'deb http://security.ubuntu.com/ubuntu xenial-security main' >> /etc/apt/sources.list"
RUN apt update > /dev/null
RUN apt install --yes \
  libjpeg-dev liblcms2-dev libtiff-dev libpng-dev \
  libz-dev libopenjp2-7-dev libcairo2-dev libglib2.0-dev \
  libgtk2.0-dev libxml2-dev sqlite3 libsqlite3-dev \
  libopenblas-base openslide-tools pkg-config ant python-pip \
  git software-properties-common > /dev/null

RUN apt install --yes openjdk-8-jdk openjdk-8-jre > /dev/null && \
  export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'

RUN bash -c "mkdir -p /{home,data} && mkdir -p /home/{openslide,openslide-java}"
VOLUME /data

COPY init-openslide.sh /home/init-openslide.sh
RUN /home/init-openslide.sh

