FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y wget && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://download.java.net/java/early_access/jdk21/28/GPL/openjdk-21-ea+xx_linux-x64_bin.tar.gz
RUN tar -xvf openjdk-21-ea+28_linux-x64_bin.tar.gz
RUN mv jdk-21 /usr/local/
RUN echo 'export JAVA_HOME=/usr/local/jdk-21' >> ~/.bashrc
RUN echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

COPY . .

RUN . ~/.bashrc && apt-get update && apt-get install -y maven && apt-get clean && rm -rf /var/lib/apt/lists/* && mvn clean install

FROM openjdk:21-jdk-slim
EXPOSE 8080

COPY --from=build /target/todolist-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar","app.jar" ]

