# imagen base
FROM debian

#Autor
MAINTAINER Jimmy Faican

# Para produccion descomentar 
RUN apt-get update -y

# java 1.8
ADD jdk-8u251-linux-x64.tar.gz /opt
RUN update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_251/bin/java 200000

# wilfly
ADD wildfly/wildfly-8.1.0.Final.tar.gz /opt
ADD wildfly/standalone.xml /opt/wildfly/standalone/configuration/standalone.xml

# PostgreSQL Client
RUN apt install -y postgresql

ENV JAVA_HOME /opt/jdk1.8.0_251
ENV JAVA_OPTS "-Xms2G -Xmx12G -XX:NewSize=2G -Duser.language=es -Duser.region=es -Dcom.sun.jersey.server.impl.cdi.lookupExtensionInBeanManager=true"

# localtime
RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/America/Guayaquil /etc/localtime

CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]

EXPOSE 8020
