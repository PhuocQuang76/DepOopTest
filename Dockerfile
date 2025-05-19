# Stage 1: Build
FROM openjdk:17-jdk-slim as builder

RUN apt-get update && apt-get install -y maven

WORKDIR /app

COPY . /app

RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR from the builder stage
COPY --from=builder /app/target/AileenDepOopTest-0.0.1-SNAPSHOT.jar .

EXPOSE 8281

ENTRYPOINT ["java", "-jar", "AileenDepOopTest-0.0.1-SNAPSHOT.jar"]