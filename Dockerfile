# Stage 1: Build Stage (Optional if you already have the JAR)
# If you're just packaging an existing students.jar, you can skip this stage
FROM 3.9.9-eclipse-temurin-21-alpine AS builder

WORKDIR /app

# Copy source code and build (optional)
# COPY . .
# RUN mvn clean package -DskipTests

# OR just copy your existing JAR if already built
# We'll assume students.jar is already built and located in your local context
COPY students.jar .

# Stage 2: Runtime Stage
FROM 21-jre-alpine
WORKDIR /app
# Copy the JAR from the builder stage
COPY --from=builder /app/students.jar .
# Expose the port (adjust if your app runs on a different port)
EXPOSE 8181
# Run the JAR
ENTRYPOINT ["java", "-jar", "students.jar"]



#=======================================
# ---------- Stage 1: Build ----------gives 81mb
#FROM maven:3.9.4-eclipse-temurin-17-alpine AS builder
#WORKDIR /app
#COPY pom.xml .
#COPY src ./src
#RUN mvn clean package -DskipTests

# ---------- Stage 2: Runtime ----------
#FROM eclipse-temurin:17-jre-alpine
#WORKDIR /app
#COPY target/students.jar students.jar
#ENTRYPOINT ["java", "-jar", "students.jar"]
#=======================================

#---------------------------- gives 240mb aprox
#FROM openjdk:17-jdk-slim
#EXPOSE 8181
#add target/students.jar students.jar
#ENTRYPOINT ["java", "-jar", "/students.jar"]