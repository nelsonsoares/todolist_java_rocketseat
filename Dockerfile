FROM ubuntu:latest AS build

RUN apt-get update

RUN apt-get install -y wget
RUN wget https://download.java.net/java/early_access/jdk21/28/GPL/openjdk-21-ea+xx_linux-x64_bin.tar.gz
RUN tar -xvf openjdk-21-ea+28_linux-x64_bin.tar.gz
RUN cd jdk-21
RUN sudo mkdir -p /usr/local/jdk-21
RUN sudo mv * /usr/local/jdk-21
RUN export JAVA_HOME=/usr/local/jdk-21
RUN export PATH=$JAVA_HOME/bin:$PATH
RUN source ~/.bashrc
RUN echo 'export JAVA_HOME=/usr/local/jdk-21' >> ~/.bashrc
RUN echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
RUN source ~/.bashrc
RUN java --version
RUN echo $JAVA_HOME 

COPY . .

RUN apt-get install maven -y
RUN mvn clean install


FROM openjdk:21-jdk-slim

EXPOSE 8080

COPY --from=build /target/todolist-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar","app.jar" ]