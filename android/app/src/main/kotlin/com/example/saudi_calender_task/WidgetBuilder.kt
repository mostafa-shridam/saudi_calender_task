package com.example.saudi_calender_task

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import java.text.SimpleDateFormat
import java.util.*

object WidgetBuilder {
    fun updateEventsView(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        data: EventsEntryData
    ) {
        val views = RemoteViews(context.packageName, R.layout.events_widget)

        val currentDate = SimpleDateFormat("dd/MM/yyyy", Locale("ar")).format(Date())
        views.setTextViewText(R.id.todayDate, "التاريخ: $currentDate")

        val events = data.events.take(5)

        events.forEachIndexed { index, event ->
            val eventId = index + 1
            val formattedDate = SimpleDateFormat("dd/MM/yyyy", Locale("ar")).format(event.eventDate)
            val daysRemaining = ((event.eventDate.time - Date().time) / (1000 * 60 * 60 * 24)).toInt()

            val titleId = context.resources.getIdentifier("event${eventId}_title", "id", context.packageName)
            val dateId = context.resources.getIdentifier("event${eventId}_date", "id", context.packageName)
            val daysId = context.resources.getIdentifier("event${eventId}_days", "id", context.packageName)

            views.setTextViewText(titleId, event.title)
            views.setTextViewText(dateId, formattedDate)
            views.setTextViewText(daysId, "$daysRemaining يوم")

            val intent = Intent(context, MainActivity::class.java).apply {
                action = "OPEN_EVENT"
                putExtra("eventId", event.eventId)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            }

            val pendingIntent = PendingIntent.getActivity(
                context, eventId, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )

            views.setOnClickPendingIntent(titleId, pendingIntent)
            views.setOnClickPendingIntent(dateId, pendingIntent)
            views.setOnClickPendingIntent(daysId, pendingIntent)
        }

        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}
