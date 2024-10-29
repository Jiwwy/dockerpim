# imagen base
FROM debian

#Autor
MAINTAINER Jimmy Faican

#INSTALLL JAVA 21
ENV JAVA_HOME /opt/jdk-21
ENV PATH $PATH:$JAVA_HOME/bin
RUN apt update \
    && apt upgrade -y \
    && apt install  wget zip unzip postgresql-client -y \
    && wget https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz \
    && tar xvf openjdk-21.0.2_linux-x64_bin.tar.gz \
    && rm openjdk-21.0.2_linux-x64_bin.tar.gz \
    && mv jdk-21.0.2/ /opt/jdk-21
# INSTALL WILDFLY 26
ENV WILDFLY_VERSION 26.1.3.Final
ENV JBOSS_HOME /opt/wildfly

RUN wget --no-check-certificate https://github.com/wildfly/wildfly/releases/download/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.zip \
    && unzip wildfly-$WILDFLY_VERSION.zip \
    && rm wildfly-$WILDFLY_VERSION.zip \
    && mv wildfly-$WILDFLY_VERSION /opt/wildfly

# BOOT WILDFLY
CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
EXPOSE 8020
