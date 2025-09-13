# ---- Build Stage ----
# Use a specific Gradle image with JDK 17 to build the application
FROM gradle:8.3-jdk17-focal AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle wrapper, build script, settings file, and the gradle directory
COPY gradlew build.gradle.kts settings.gradle.kts ./
COPY gradle ./gradle

# Copy the source code of the application
COPY src ./src

# Grant executable permissions to the Gradle wrapper
RUN chmod +x ./gradlew

# Build the application, creating a "fat jar" that includes all dependencies.
# The --no-daemon flag is recommended for CI/CD environments.
RUN ./gradlew shadowJar --no-daemon

# ---- Package Stage ----
# Use a lightweight JRE image from the Eclipse Temurin project
FROM eclipse-temurin:17-jre-focal

# Set the working directory
WORKDIR /app

# Copy the fat jar from the build stage into the final image
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port 8080, which is the default port for Ktor applications
EXPOSE 8080

# The command to run the application when the container starts
ENTRYPOINT ["java", "-jar", "app.jar"]
