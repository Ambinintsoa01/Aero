docker run --rm -v "D:\ITU\S5\Mme_Baovola\Compagnie_aero:/app" -w /app maven:3.9-eclipse-temurin-17 mvn clean package
docker-compose restart tomcat