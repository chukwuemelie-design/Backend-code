FROM ubuntu

RUN apt-get update ; apt-get install -y
RUN apt install openjdk-17-jdk-headless -y
RUN apt install mvn -y

WORKDIR /app

COPY ./src /app/src
COPY ./pom.xml /app

RUN mvn -f /app/pom.xml clean package -DskipTests

RUN ls -la /app/target

RUN mv /app/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
