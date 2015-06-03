FROM ubuntu:vivid

RUN apt-get -y update
RUN apt-get install -y openjdk-8-jdk docker.io
RUN apt-get install -y unzip

VOLUME /root/.ivy2
WORKDIR /opt/app

RUN mkdir -p /opt/app 
RUN mkdir -p /opt/target

ADD builder.sh /opt/builder.sh
CMD /bin/bash /opt/builder.sh


