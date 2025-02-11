package com.example.saudi_calender_task

import java.util.Date

data class Event(
    val eventId: String?,
    val title: String?,
    val eventDate: Date?
)

data class EventsEntryData(val events: List<Event>)