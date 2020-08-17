FROM ubuntu

# Install maven
RUN apt-get -y update  && apt-get install default-jre default-jdk openjdk-8-jdk  maven -y

WORKDIR /code

# Prepare by downloading dependencies
ADD pom.xml /code/pom.xml

# Adding source, compile and package into a fat jar
ADD src /code/src
RUN ["mvn", "clean", "compile"]
 
#RUN ["mvn", "package"]
RUN ls -a target
EXPOSE 8113
CMD ["java","-Dspring.profiles.active=dev","-jar","target/ha-authcode-generation-service.jar"]
