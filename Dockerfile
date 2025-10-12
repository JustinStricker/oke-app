# Stage 1: Cache Gradle dependencies
# Use a specific image with a compatible JDK (e.g., 21) instead of 'latest'
FROM gradle:8.9.0-jdk21 AS cache
RUN mkdir -p /home/gradle/cache_home
ENV GRADLE_USER_HOME=/home/gradle/cache_home
COPY build.gradle.kts settings.gradle.kts /home/gradle/app/
WORKDIR /home/gradle/app
# Run dependency resolution to populate the cache
RUN gradle dependencies --no-daemon

# Stage 2: Build Application
# Use the same specific JDK version for the build stage
FROM gradle:8.9.0-jdk21 AS build
# Copy the populated cache from the 'cache' stage
COPY --from=cache /home/gradle/cache_home /home/gradle/.gradle
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
# Build the fat JAR (shadowJar is a common task for this)
# The Ktor plugin often uses 'shadowJar' by default for fat JARs
RUN gradle shadowJar --no-daemon

# Stage 3: Create the Runtime Image
# Use a JRE (Java Runtime Environment) which is smaller than a full JDK
FROM amazoncorretto:22-al2-jre AS runtime
EXPOSE 8080
RUN mkdir /app
# Correctly copy the JAR from the build stage. The shadowJar task produces a jar with "-all" in the name.
COPY --from=build /home/gradle/src/build/libs/*-all.jar /app/ktor-app.jar
ENTRYPOINT ["java","-jar","/app/ktor-app.jar"]
