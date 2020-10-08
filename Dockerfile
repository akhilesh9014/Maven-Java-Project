FROM centos

MAINTAINER rns@rnstech.com

RUN yum update -y
RUN yum -y install java
RUN java -version
RUN yum install wget -y

#RUN mkdir /opt/tomcat/

WORKDIR /opt
RUN wget http://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.43/bin/apache-tomcat-8.5.43.tar.gz
RUN tar xvf apache-tomcat-8.5.43.tar.gz -C /opt/
RUN cp -R /opt/apache-tomcat-8.5.43/ /opt/tomcat

WORKDIR /opt/tomcat/webapps
COPY target/*.war /opt/tomcat/webapps/webapp.war

EXPOSE 8080

ENTRYPOINT ["/opt/tomcat/bin/catalina.sh", "run"]
