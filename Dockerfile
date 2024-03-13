# CentOS 7 image
FROM centos:7

# Dependencies
RUN yum install java -y

RUN mkdir /opt/tomcat/
# Copy files, folders, or remote URLs from source to the dest path in the image's filesystem (/opt).
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.99/bin/apache-tomcat-8.5.99.tar.gz /
RUN tar -xzf apache-tomcat-8.5.99.tar.gz 
RUN mv apache-tomcat-8.5.99/* /opt/tomcat/.

# Env variables
#ENV CATALINA_HOME /opt/apache-tomcat-8.5.99
#ENV PATH $CATALINA_HOME/bin:$PATH


# Download the sample.war file from the specified URL and saves it in the current working directory ($CATALINA_HOME/webapps).
WORKDIR /opt/tomcat/webapps
RUN curl -O https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war

# Expose the default Tomcat SSL port
EXPOSE 4041

# Start Tomcat with SSL
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
