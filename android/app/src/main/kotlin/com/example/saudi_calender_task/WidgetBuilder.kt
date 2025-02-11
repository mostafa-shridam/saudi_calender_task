package com.example.saudi_calender_task

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.app.PendingIntent
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
        if (data.events.isEmpty()){
            val views = RemoteViews(context.packageName, R.layout.empty_widget)
            val intent = Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.secondWidget, pendingIntent)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }else{
            val views = RemoteViews(context.packageName, R.layout.events_widget)
            val currentDate = SimpleDateFormat("dd - MM - yyyy", Locale("en")).format(Date())
            views.setTextViewText(R.id.todayDate, "التاريخ: $currentDate")
            val events = data.events.take(5)

            events.forEachIndexed { index, event ->
                val eventId = index + 1
                val formattedDate = event.eventDate?.let {
                    SimpleDateFormat("dd - MM - yyyy", Locale("ar")).format(it)
                } ?: "تاريخ غير متاح"

                val daysRemaining = event.eventDate?.let {
                    ((it.time - Date().time) / (1000 * 60 * 60 * 24)).toInt()
                } ?: 0

                val dayName = when {
                    daysRemaining == 0 -> "اليوم"
                    daysRemaining in 1..10 -> "أيام"
                    else -> "يوم"
                }

                setTextViewTextSafely(context, views, "event${eventId}_title", event.title ?: "حدث غير معروف")
                setTextViewTextSafely(context, views, "event${eventId}_date", formattedDate)
                setTextViewTextSafely(context, views, "event${eventId}_days", "$daysRemaining\n$dayName")
            }

            for (i in events.size until 5) {
                val eventId = i + 1
                setTextViewTextSafely(context, views, "event${eventId}_title", "")
                setTextViewTextSafely(context, views, "event${eventId}_date", "")
                setTextViewTextSafely(context, views, "event${eventId}_days", "")
            }

            val intent = Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widgetID, pendingIntent)

            // تحديث الودجت
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun setTextViewTextSafely(context: Context, views: RemoteViews, idName: String, text: String) {
        val resId = context.resources.getIdentifier(idName, "id", context.packageName)
        if (resId != 0) {
            views.setTextViewText(resId, text)
        }
    }
}
