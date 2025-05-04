# ---------- Stage 1: Build ----------gives 81mb
FROM maven:3.9.4-eclipse-temurin-17-alpine AS builder
WORKDIR /app
# Copy only the dependency-related files first (to leverage caching)
COPY pom.xml .
COPY src ./src
# Build the application
RUN mvn clean package -DskipTests

# ---------- Stage 2: Runtime ----------
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Copy only the built jar from the builder stage
#COPY --from=builder target/student.jar .
COPY target/students.jar students.jar
# Command to run the JAR
ENTRYPOINT ["java", "-jar", "students.jar"]

#---------------------------- gives 240mb aprox
#FROM openjdk:17-jdk-slim
#EXPOSE 8181
#add target/students.jar students.jar
#ENTRYPOINT ["java", "-jar", "/students.jar"]