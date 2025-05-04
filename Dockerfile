# Stage 1: Build with Maven and Java 24
FROM maven:3.9.9-eclipse-temurin-24-alpine AS builder

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime with distroless (Java 24)
FROM gcr.io/distroless/java24-debian11

COPY --from=builder /app/target/students.jar /students.jar
ENTRYPOINT ["java", "-jar", "/students.jar"]


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