FROM tomcat:9.0
LABEL maintainer="Biplab Adhikari"
# COPY path-to-application-war path-to-webapps-in-docker-tomcat
COPY ./project/target/*.war /usr/local/tomcat/webapps/