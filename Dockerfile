FROM ubuntu:latest AS build

RUN pt-get update
RUN add-apt-repository ppa:openjdk-r/ppa

RUN apt-get update
RUN apt-get install openjdk-21-jdk -y

RUN apt-get update
RUN apt-get install openjdk-21-jdk
RUN apt-get update

COPY . .

RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:21-jdk-slim
EXPOSE 8080

COPY --from=build /target/todolist-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar","app.jar" ]