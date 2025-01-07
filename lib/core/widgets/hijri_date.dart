import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

/// Get the current Hijri and Miladi dates as a formatted string
String hijriDateAndMiladiDate() {
  final now = DateTime.now();

  // Hijri date
  final hDate = HijriCalendar.fromDate(now);
  HijriCalendar.language = 'en';
  final dayHijri = hDate.toFormat('dd');
  final yearHijri = hDate.toFormat('yyyy');

  HijriCalendar.language = 'ar';
  final monthHijri = hDate.toFormat('MMMM');

  // Gregorian date
  final dayGreg = DateFormat('dd', 'en').format(now);
  final yearGreg = DateFormat('yyyy', 'en').format(now);
  final monthGreg = DateFormat('MMMM', 'ar').format(now);

  // Formatted result
  final formattedHijriDate = '$dayHijri $monthHijri $yearHijri';
  final formattedDate = "$formattedHijriDate - $dayGreg $monthGreg $yearGreg";

  return formattedDate;
}

/// Get the event date in both Hijri and Miladi formats with day name
String eventDate(String date) {
  final eventDate = DateTime.parse(date);

  // Hijri date
  final hDate = HijriCalendar.fromDate(eventDate);
  HijriCalendar.language = 'en';
  final dayHijri = hDate.toFormat('dd');
  final yearHijri = hDate.toFormat('yyyy');

  HijriCalendar.language = 'ar';
  final monthHijri = hDate.toFormat('MMMM');

  // Miladi date
  final dayGreg = DateFormat('dd', 'en').format(eventDate);
  final yearGreg = DateFormat('yyyy', 'en').format(eventDate);
  final monthGreg = DateFormat('MMMM', 'ar').format(eventDate);

  // Day name
  final dayName = DateFormat('EEEE', 'ar').format(eventDate);

  // Formatted result
  final formattedHijriDate = '$dayHijri $monthHijri $yearHijri';
  final formattedDate =
      "$dayName $dayGreg $monthGreg $yearGreg - $formattedHijriDate";

  return formattedDate;
}

/// A utility class for calculating time differences
class CustomDates {
  final DateTime now = DateTime.now();

  /// Get the difference in days
  String dateInDays(String date) {
    final eventDate = parseDate(date);
    final days = eventDate.difference(now).inDays;
    return days > 0 ? days.toString() : defultEnd;
  }

  /// Get the difference in hours
  String dateInHours(String date) {
    final eventDate = parseDate(date);
    final hours = eventDate.difference(now).inHours % 24;
    return hours > 0 ? hours.toString() : defultEnd;
  }

  /// Get the difference in minutes
  String dateInMinutes(String date) {
    final eventDate = parseDate(date);
    final minutes = eventDate.difference(now).inMinutes % 60;
    return minutes > 0 ? minutes.toString() : defultEnd;
  }

  String dateInMinutesWithRedTextColor(String date) {
    final eventDate = parseDate(date);
    final minutes = eventDate.difference(now).inMinutes % 60;
    return minutes <= 10 ? minutes.toString() : defultEnd;
  }

  /// Get the difference in seconds
  String dateInSeconds(String date) {
    final eventDate = parseDate(date);
    final seconds = eventDate.difference(now).inSeconds % 60;
    return seconds > 0 ? seconds.toString() : defultEnd;
  }
}

/// Parse a date string into a DateTime object
DateTime parseDate(String dateString) {
  try {
    return DateTime.parse(dateString);
  } catch (e) {
    try {
      return DateFormat("yyyy-MM-dd hh:mm a").parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }
}

/// A constant for the "End" label
const String defultEnd = "End";
