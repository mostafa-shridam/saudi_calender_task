package com.example.saudi_calender_task

import android.appwidget.AppWidgetManager
import android.os.Bundle
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.util.Log
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetPlugin
import org.json.JSONArray
import java.text.SimpleDateFormat
import java.util.*

class EventsWidget : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        val data = getData(context, widgetData)
        appWidgetIds.forEach { widgetId ->
            WidgetBuilder.updateEventsView(context, appWidgetManager, widgetId, data)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == AppWidgetManager.ACTION_APPWIDGET_UPDATE) {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val thisAppWidget = ComponentName(context, javaClass)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(thisAppWidget)
            val data = getData(context, HomeWidgetPlugin.getData(context))
            appWidgetIds.forEach { widgetId ->
                WidgetBuilder.updateEventsView(context, appWidgetManager, widgetId, data)
            }
        }
    }

    private fun getData(context: Context, widgetData: SharedPreferences): EventsEntryData {
        val events = ArrayList<Event>()
        val format = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.US)
        val eventsStr = widgetData.getString("events", "[]") ?: "[]"

        try {
            val jsonArray = JSONArray(eventsStr)
            for (i in 0 until jsonArray.length()) {
                val obj = jsonArray.getJSONObject(i)
                val eventId = obj.optString("eventId", "")
                val title = obj.optString("title", "حدث غير معروف")
                val eventDateStr = obj.optString("eventDate", "")
                val eventDate = eventDateStr.takeIf { it.isNotEmpty() }?.let { format.parse(it) }

                if (eventDate != null && eventDate.after(Date())) {
                    events.add(Event(eventId, title, eventDate))
                }
            }
        } catch (e: Exception) {
            Log.e("EventsWidget", "Error parsing events JSON", e)
        }
        return EventsEntryData(events)
    }
    override fun onEnabled(context: Context){
        super.onEnabled(context)
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle?
    ) {
        val data = getData(context, HomeWidgetPlugin.getData(context))
        WidgetBuilder.updateEventsView(context, appWidgetManager, appWidgetId, data)
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
    }

    override fun onDisabled(context: Context) {
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val thisAppWidgetComponentName = ComponentName(context.packageName, javaClass.name)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(thisAppWidgetComponentName)
        if (appWidgetIds.isEmpty()) {
            Log.d("EventsWidget", "All widgets disabled.")
        }
    }
}