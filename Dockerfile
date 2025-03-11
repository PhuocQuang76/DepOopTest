# Define the final stage using OpenJDK as base image
FROM openjdk:17-jdk

#expose this port for the application
EXPOSE 8281

#copy this jar from local to container
ADD target/depoop-test-image.jar depoop-test-image.jar

#copy this jar
ENTRYPOINT ["java", "-jar", "depoop-test-image.jar"]