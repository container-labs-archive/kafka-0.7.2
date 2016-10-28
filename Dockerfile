FROM ubuntu:trusty

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get update && \
  apt-get install -y --force-yes unzip wget coreutils openjdk-7-jdk

RUN mkdir /app

RUN wget http://archive.apache.org/dist/kafka/old_releases/kafka-0.7.2-incubating/kafka-0.7.2-incubating-src.tgz -O "/tmp/kafka.tgz"
RUN tar xfz /tmp/kafka.tgz -C /app && rm /tmp/kafka.tgz


RUN cd /app/kafka-0.7.2-incubating-src && ./sbt update
RUN cd /app/kafka-0.7.2-incubating-src && ./sbt package

VOLUME ["/kafka"]


CMD ["/app/kafka-0.7.2-incubating-src/bin/kafka-server-start.sh", "/app/kafka-0.7.2-incubating-src/config/server.properties"]

