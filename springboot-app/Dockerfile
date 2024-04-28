FROM openjdk:17-jdk-alpine

#copy is not required as running (`./mvnw clean verify`) will generate a Spring Boot flat JAR in the target folder
#COPY target/springboot-app-*.jar springboot-app-*.jar

ENTRYPOINT ["java","-jar","target/springboot-app-*.jar"]