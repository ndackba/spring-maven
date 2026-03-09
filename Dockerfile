# -------- STAGE 1 : BUILD --------
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

# installer maven
RUN apt-get update && apt-get install -y maven

# copier pom.xml
COPY pom.xml .

# télécharger les dépendances
RUN mvn dependency:go-offline -B

# copier le code source
COPY src ./src

# compiler l'application
RUN mvn clean package -DskipTests

# -------- STAGE 2 : RUNTIME --------
FROM eclipse-temurin:17-jre

WORKDIR /app

# installer wget pour healthcheck
RUN apt-get update && apt-get install -y wget

# copier le jar
COPY --from=builder /app/target/docker-demo-0.0.1-SNAPSHOT.jar app.jar

# exposer le port
EXPOSE 8080

# lancer l'application
ENTRYPOINT ["java","-jar","/app/app.jar"]
