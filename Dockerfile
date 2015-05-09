FROM wurstmeister/base

MAINTAINER Wurstmeister

RUN mkdir /opt/drill
RUN wget -q -O - http://getdrill.org/drill/download/apache-drill-0.9.0.tar.gz | tar -xzf - --strip=1 -C /opt/drill

ADD start-drill.sh /opt/drill/bin/start-drill.sh

EXPOSE 8047 31010 31011 31012 46655

CMD /opt/drill/bin/start-drill.sh  && tail -f /opt/drill/log/drillbit.out
