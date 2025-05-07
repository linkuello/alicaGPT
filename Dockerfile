# Используем официальный образ Java
FROM eclipse-temurin:21-jdk

# Создаём рабочую директорию
WORKDIR /app

# Копируем Maven wrapper и POM
COPY .mvn .mvn
COPY mvnw mvnw
COPY pom.xml pom.xml

# Загружаем зависимости (до копирования исходников для кэширования)
RUN ./mvnw dependency:go-offline -B

# Копируем всё остальное
COPY src src

# Собираем JAR
RUN ./mvnw clean package -DskipTests

# Указываем порт
EXPOSE 8080

# Запускаем приложение
CMD ["java", "-jar", "target/*.jar"]
