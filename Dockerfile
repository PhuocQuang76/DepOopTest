# Define the final stage using OpenJDK as the base image
#The Dockerfile starts by defining a build stage using the openjdk:17-jdk-slim base image
#where Maven is installed to build the application.
FROM openjdk:17-jdk-slim as build

# Install Maven
RUN apt-get update && apt-get install -y maven

#It sets the working directory to /app
WORKDIR /app

# Copy the Maven project from the host to the container
#copies the Maven project files from the host machine to the container's /app directory.
COPY ./app /app

# Build the Maven project
#The Maven project is built using the mvn clean package -DskipTests command.
RUN mvn clean package -DskipTests

# Start a new stage using the base image without Maven
#A new stage is started using the openjdk:17-jdk-slim base image without Maven to
#reduce the final image size.
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the built jar file from the previous stage to the current stage
#built JAR file from the previous stage is copied to the current stage's working directory.
COPY --from=build /app/target/AileenDepOopTest-0.0.1-SNAPSHOT.jar AileenDepOopTest-0.0.1-SNAPSHOT.jar

# Expose port 8281 for the application
#Port 8281 is exposed to allow external access to the application.
EXPOSE 8281

# Define the entry point for running the application
#The ENTRYPOINT instruction specifies the command to run the application when the container starts,
#which in this case is running the JAR file with Java.
ENTRYPOINT ["java", "-jar", "AileenDepOopTest-0.0.1-SNAPSHOT.jar"]