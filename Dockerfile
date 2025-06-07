# Etapa de construção com Maven
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY project-login-app/pom.xml .
COPY project-login-app/src ./src
RUN mvn clean package -DskipTests

# Etapa de execução com OpenJDK
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]