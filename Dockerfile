FROM centos

MAINTAINER rns@rnstech.com

RUN yum update -y
RUN yum -y install java
RUN java -version
RUN yum install wget -y

#RUN mkdir /opt/tomcat/

WORKDIR /opt
RUN curl -O http://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.58/bin/apache-tomcat-8.5.58.tar.gz
RUN tar xvf apache-tomcat-8.5.58.tar.gz -C /opt/
RUN mv /opt/apache-tomcat-8.5.58 tomcat-8
RUN cp -R /opt/tomcat-8/ /opt/tomcat

WORKDIR /opt/tomcat/webapps
COPY target/*.war /opt/tomcat/webapps/visitagain.war

EXPOSE 8080

ENTRYPOINT ["/opt/tomcat/bin/catalina.sh", "run"]
