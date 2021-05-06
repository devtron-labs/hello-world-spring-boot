FROM openjdk:8-jdk-slim
ENV PORT 8080
EXPOSE 8080
RUN mkdir -p /opt/flyway/migrations
FROM gradle:jdk10 as builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle clean build
COPY src/main/resources/db/migration/V1__create_table.sql  /opt/flyway/migrations/
RUN pwd
RUN ls -ltR build/libs
RUN ls -ltR /var/lib/docker/tmp/docker-builder476886257/
USER root
COPY /home/gradle/src/build/libs/hello-forge-springboot-0.0.1-SNAPSHOT.jar /opt/
WORKDIR /opt
CMD ["java", "-jar", "app.jar"]
