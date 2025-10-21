# Runtime-only Dockerfile: assumes the JAR is already built by Jenkins (or locally)
FROM eclipse-temurin:23-jre AS runtime
WORKDIR /app

# Copy the already-built JAR from workspace into the image
# Change the jar name if your artifactId/version differs
COPY target/java-jenkins-demo-1.0-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
