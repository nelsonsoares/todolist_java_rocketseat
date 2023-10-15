FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y openjdk-21-jdk && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . .

RUN apt-get update && apt-get install -y maven && apt-get clean && rm -rf /var/lib/apt/lists/* && mvn clean install

FROM openjdk:21-jdk-slim
EXPOSE 8080

COPY --from=build /target/todolist-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar","app.jar" ]
