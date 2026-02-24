# Utilisez une image de base avec Java
FROM openjdk:17-jdk-slim
# Définir le répertoire de travail dans le conteneur
WORKDIR /app
# Copier le fichier jar généré dans le conteneur
COPY target/docker-demo-0.0.1-SNAPSHOT.jar docker-demo.jar
# Exposer le port sur lequel Spring Boot écoute
EXPOSE 8080
# Commande pour lancer l'application Spring Boot
ENTRYPOINT ["java", "-jar", "/app/docker-demo.jar"]
