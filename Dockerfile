FROM ubuntu

RUN apt-get update ; apt-get install -y
RUN apt install openjdk-17-jre-headless -y
RUN apt install maven -y

WORKDIR /app

COPY ./src /app/src
COPY ./pom.xml /app

RUN maven -f /app/pom.xml clean package -DskipTests

COPY ./target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]


