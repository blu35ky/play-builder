FROM java:8

RUN apt-get update && apt-get install -y docker.io unzip && apt-get clean

VOLUME /root/.ivy2
WORKDIR /opt/app

RUN mkdir -p /opt/app 
RUN mkdir -p /opt/target

ADD builder.sh /opt/builder.sh
CMD /bin/bash /opt/builder.sh


