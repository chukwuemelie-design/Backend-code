FROM ubuntu

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk-headless \
    maven \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY ./pom.xml /app
COPY ./src /app/src
COPY .env.example /app/src/main/resources/env.example

RUN mvn -f /app/pom.xml clean package -DskipTests


RUN mv /app/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
