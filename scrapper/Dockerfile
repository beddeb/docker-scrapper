FROM openjdk:23-jdk
WORKDIR /app
COPY target/scrapper.jar /app/
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "scrapper.jar"]