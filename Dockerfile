FROM quintenk/jdk-oracle:7

MAINTAINER Wurstmeister 
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list; apt-get update; apt-get install -y protobuf-compiler maven git bzip2 build-essential
RUN mkdir /opt/protobuf-2.5.0 ; wget -qO- wget http://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2 | tar --strip-components=1 -jxvf - -C /opt/protobuf-2.5.0; cd /opt/protobuf-2.5.0; ./configure ; make; make install 
RUN cd /opt; git clone https://git-wip-us.apache.org/repos/asf/incubator-drill.git 
RUN cd /opt/incubator-drill; mvn clean install -DskipTests

ENV LAST_GIT_UPDATE 2014-01-12
RUN cd /opt/incubator-drill; git pull; mvn clean install -DskipTests
RUN cd /opt/incubator-drill; ./sqlline -u jdbc:drill:schema=parquet-local -n admin -p admin
CMD cd /opt/incubator-drill; ./sqlline -u jdbc:drill:schema=parquet-local -n admin -p admin
