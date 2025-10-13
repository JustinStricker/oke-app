package com.example

import java.util.concurrent.atomic.AtomicInteger

object CounterService {
    private val counter = AtomicInteger(0)
    
    fun getCurrent(): Int = counter.get()
    fun increment(): Int = counter.incrementAndGet()
}
