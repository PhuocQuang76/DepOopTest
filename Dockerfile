# Use a specific version of the JDK for better reproducibility
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the JAR file (make sure your pom.xml builds a single JAR with dependencies)
COPY target/AileenDepOopTest-0.0.1-SNAPSHOT.jar AileenDepOopTest-0.0.1-SNAPSHOT.jar

# Expose the port your app runs on
EXPOSE 8088

# Run the application
ENTRYPOINT ["java", "-jar", "AileenDepOopTest-0.0.1-SNAPSHOT.jar"]

# # Stage 1: Build
# FROM openjdk:17-jdk-slim as builder
#
# RUN apt-get update && apt-get install -y maven
#
# WORKDIR /app
#
# COPY . /app
#
# RUN mvn clean package -DskipTests
#
# # Stage 2: Runtime
# FROM openjdk:17-jdk-slimdocker run -p 8281:8281 ghcr.io/phuocquang76/depooptest:latest
#
# WORKDIR /app
#
# # Copy the JAR from the builder stage
# COPY --from=builder /app/target/AileenDepOopTest-0.0.1-SNAPSHOT.jar .
#
# EXPOSE 8281
#
# ENTRYPOINT ["java", "-jar", "AileenDepOopTest-0.0.1-SNAPSHOT.jar"]