# oke-app

This project was created using the [Ktor Project Generator](https://start.ktor.io).

Here are some useful links to get you started:

- [Ktor Documentation](https://ktor.io/docs/home.html)
- [Ktor GitHub page](https://github.com/ktorio/ktor)
- The [Ktor Slack chat](https://app.slack.com/client/T09229ZC6/C0A974TJ9). You'll need
  to [request an invite](https://surveys.jetbrains.com/s3/kotlin-slack-sign-up) to join.

## Features

Here's a list of features included in this project:

| Name                                       | Description                                              |
|--------------------------------------------|----------------------------------------------------------|
| [Routing](https://start.ktor.io/p/routing) | Provides a structured routing DSL                        |
| **Counter Service**                        | Thread-safe counter with AtomicInteger implementation    |

## API Endpoints

| Endpoint   | Method | Description                          |
|------------|--------|--------------------------------------|
| `/`        | GET    | Returns current counter value + instructions |
| `/counter` | GET    | Increments counter and returns new value |

## Building & Running

## Building & Running

To build or run the project, use one of the following tasks:

| Task                          | Description                                                          |
|-------------------------------|----------------------------------------------------------------------|
| `./gradlew test`              | Run the tests                                                        |
| `./gradlew build`             | Build everything                                                     |
| `buildFatJar`                 | Build an executable JAR of the server with all dependencies included |
| `buildImage`                  | Build the docker image to use with the fat JAR                       |
| `publishImageToLocalRegistry` | Publish the docker image locally                                     |
| `run`                         | Run the server                                                       |
| `runDocker`                   | Run using the local docker image                                     |

If the server starts successfully, you'll see the following output:

```
2024-12-04 14:32:45.584 [main] INFO  Application - Application started in 0.303 seconds.
2024-12-04 14:32:45.682 [main] INFO  Application - Responding at http://0.0.0.0:8080
```

### Testing Endpoints
- View counter: `curl http://localhost:8080`
- Increment counter: `curl http://localhost:8080/counter`

Example session:
```bash
$ curl http://localhost:8080
Current counter value: 0
Increment the counter by visiting /counter

$ curl http://localhost:8080/counter
Counter incremented!
New value: 1
Return to main page: /
```
