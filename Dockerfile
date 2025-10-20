# Multi-stage Dockerfile: build with Maven, run with a slim JRE

# ✅ Use a valid Maven + Temurin JDK 23 image
FROM maven:3.9.9-eclipse-temurin-23 AS build

WORKDIR /workspace

# Copy only pom.xml first for dependency caching
COPY pom.xml .

# Pre-download dependencies to speed up builds
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the app (skip tests for faster image build)
RUN mvn -B -DskipTests package

# ✅ Use lightweight JRE image for runtime
FROM eclipse-temurin:23-jre

WORKDIR /app

# Copy built JAR from the builder stage
COPY --from=build /workspace/target/java-jenkins-demo-1.0-SNAPSHOT.jar app.jar

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
