# Use an official OpenJDK runtime as a parent image
# FROM adoptopenjdk/openjdk11:jre-11.0.11_9-alpine
FROM openjdk:17-jdk-slim

# Set the working directory to /app
WORKDIR /app

# Copy the Maven executable to the container
COPY mvnw .

# Copy the Maven wrapper files to the container
COPY .mvn .mvn

# Copy the pom.xml and other necessary files to the container
COPY pom.xml .

# Download all dependencies for caching
RUN ./mvnw dependency:go-offline

# Copy the rest of the application files to the container
COPY src src

# Build the application
RUN ./mvnw package -DskipTests

# Expose the port that the application will listen on
EXPOSE 8080

# Set the default command to start the application
RUN chmod +x /app/target/spring-petclinic-3.0.0-SNAPSHOT.jar

CMD ["java", "-jar", "/app/target/spring-petclinic-3.0.0-SNAPSHOT.jar"]
# RUN ls /app/target/


# CMD ["java", "-jar", "/app/target/*.jar"]

