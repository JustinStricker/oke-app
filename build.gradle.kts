import org.gradle.api.JavaVersion
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

val logback_version: String by project

repositories {
    mavenCentral()
}

plugins {
    kotlin("jvm") version "2.0.0" // Use a stable Kotlin version
    id("io.ktor.plugin") version "2.3.12"
    id("com.github.johnrengelman.shadow") version "8.1.1" // Add shadow plugin for fat JARs
}

group = "com.example"
version = "0.0.1"

application {
    mainClass = "io.ktor.server.netty.EngineMain"
}

// Add this block to enforce a consistent JDK version for compilation
java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

dependencies {
    implementation("io.ktor:ktor-server-core-jvm")
    implementation("io.ktor:ktor-server-netty-jvm")
    implementation("ch.qos.logback:logback-classic:$logback_version")
    implementation("io.ktor:ktor-server-config-yaml")
    testImplementation("io.ktor:ktor-server-tests-jvm")
    testImplementation(kotlin("test-junit"))
}

// Configure Kotlin tasks to use the same JVM target
tasks.withType<KotlinCompile> {
    kotlinOptions.jvmTarget = "21"
}
