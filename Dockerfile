# Base Image
FROM centos:7

# Install Java
RUN yum install -y java

# Create directories for Tomcat and SSL (-p - +1 directory)
RUN mkdir -p /opt/tomcat/ssl

# Copy CA´s
COPY ca-public.pem /opt/tomcat/ssl/ca-public.pem
COPY ca-private.pem /opt/tomcat/ssl/ca-private.pem

# Download and Extract Tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.99/bin/apache-tomcat-8.5.99.tar.gz /
RUN tar -xzf apache-tomcat-8.5.99.tar.gz
RUN mv apache-tomcat-8.5.99/* /opt/tomcat/.

# Generate SSL Certificate
RUN keytool -genkeypair -alias tomcat -keyalg RSA -keysize 2048 \
    -keystore /opt/tomcat/ssl/keystore.jks -storepass changeit \
    -dname "CN=localhost, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown" \
    -validity 3650

# Configure Tomcat to Use SSL
RUN sed -i 's/<Connector port="8080"/<Connector port="4041" scheme="https" secure="true" \
    SSLEnabled="true" keystoreFile="\/opt\/tomcat\/ssl\/keystore.jks" \
    keystorePass="changeit" /' /opt/tomcat/conf/server.xml

# Set Permissions
RUN chmod -R 600 /opt/tomcat/ssl

# Download the sample.war file from the specified URL and saves it in the current working directory ($CATALINA_HOME/webapps).
WORKDIR /opt/tomcat/webapps
RUN curl -O https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war

# Expose Port 4041 for SSL
EXPOSE 4041

# Set Environment Variables
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Start Tomcat
CMD ["catalina.sh", "run"]