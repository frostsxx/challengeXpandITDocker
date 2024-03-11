# CentOS 7 image
FROM centos:7

# Dependencies
RUN yum install java -y

# Copy files, folders, or remote URLs from source to the dest path in the image's filesystem (/opt).
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.99/bin/apache-tomcat-8.5.99.tar.gz /
RUN tar -xzf apache-tomcat-8.5.99.tar.gz -C /opt

# Env variables
ENV CATALINA_HOME /opt/apache-tomcat-8.5.99 
ENV PATH $CATALINA_HOME/bin:$PATH

## Set the environment variables for Tomcat
##ENV CATALINA_HOME /opt/tomcat
##ENV PATH $CATALINA_HOME/bin:$PATH

## Download and extract Apache Tomcat 8.5
##WORKDIR /opt/tomcat/webapps


# Download the sample.war file from the specified URL and saves it in the current working directory ($CATALINA_HOME/webapps).
WORKDIR $CATALINA_HOME/webapps
RUN curl -O https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war

# Expose the default Tomcat SSL port
EXPOSE 4041

# Start Tomcat with SSL
CMD ["catalina.sh", "run"]
