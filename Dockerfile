FROM openjdk:20-slim

RUN mkdir -p "/root/minecraft"
RUN mkdir -p "/root/config"

WORKDIR /root/minecraft

COPY resources/creative_server.properties "/root/config"
COPY resources/survival_server.properties "/root/config"
COPY resources/eula.txt "/root/config"
COPY resources/mc_entrypoint.sh .

RUN apt-get update && apt-get -y install wget git

RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN java -jar BuildTools.jar --rev latest

ENTRYPOINT ["/root/minecraft/mc_entrypoint.sh"]