FROM openjdk:23-jdk
WORKDIR /app
COPY target/bot.jar /app/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "bot.jar"]