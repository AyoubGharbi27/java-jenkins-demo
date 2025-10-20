# Multi-stage Dockerfile: build with Maven, run with a slim JRE
FROM maven:3.9.6-eclipse-temurin-24 as build
WORKDIR /workspace
COPY pom.xml .
COPY src ./src
# build the app (no tests by default)
RUN mvn -B -DskipTests package

FROM eclipse-temurin:24-jre
WORKDIR /app
COPY --from=build /workspace/target/java-jenkins-demo-1.0-SNAPSHOT.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
