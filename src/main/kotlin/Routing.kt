package com.example

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureRouting() {
    routing {
        get("/") {
            val current = CounterService.getCurrent()
            call.respondText("""
                Current counter value: $current
                Increment the counter by visiting /counter
            """.trimIndent())
        }
        
        get("/counter") {
            val newValue = CounterService.increment()
            call.respondText("""
                Counter incremented!
                New value: $newValue
                Return to main page: /
            """.trimIndent())
        }
    }
}
