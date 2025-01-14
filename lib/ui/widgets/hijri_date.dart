import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

/// Get the current Hijri and Miladi dates as a formatted string
String hijriDateAndMiladiDate({String? date}) {
  final eventDate = DateTime.tryParse(date ?? DateTime.now().toString()) ??
      DateTime.parse(date?.split(" ")[0] ?? DateTime.now().toString());
  // Hijri date
  final hDate = HijriCalendar.fromDate(eventDate);
  HijriCalendar.language = 'en';
  final dayHijri = hDate.toFormat('dd');
  final yearHijri = hDate.toFormat('yyyy');

  HijriCalendar.language = 'ar';
  final monthHijri = hDate.toFormat('MMMM');

  // Gregorian date
  final dayGreg = DateFormat('dd', 'en').format(eventDate);
  final yearGreg = DateFormat('yyyy', 'en').format(eventDate);
  final monthGreg = DateFormat('MMMM', 'ar').format(eventDate);

  // Formatted result
  final formattedHijriDate = '$dayHijri $monthHijri $yearHijri';
  final formattedDate = "$formattedHijriDate - $dayGreg $monthGreg $yearGreg";

  return formattedDate;
}

/// Get the event date in both Hijri and Miladi formats with day name
String parseEventDate({String? date}) {
  final eventDate = DateTime.tryParse(date?.split(" ")[0] ?? DateTime.now().toString()) ??
      DateTime.parse(date?.split(" ")[0] ?? DateTime.now().toString());

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

/// A constant for the "End" label
const String defultEnd = "منتهي";
