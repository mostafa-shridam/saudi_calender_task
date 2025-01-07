import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

String hijriDateAndMiladi() {
    final now = DateTime.now();

    // hijri date
    final hDate = HijriCalendar.fromDate(now);
    HijriCalendar.language = 'en';
    final dayAr = hDate.toFormat('dd');
    final yearAr = hDate.toFormat('yyyy');

    HijriCalendar.language = 'ar';
    final monthAr = hDate.toFormat('MMMM');

    // miladi date
    final dayEn = DateFormat('dd', 'en').format(now);
    final yearEn = DateFormat('yyyy', 'en').format(now);
    final monthEn = DateFormat('MMMM', 'ar').format(now);

    // day name

  final String formattedHijriDate =
      '$dayAr $monthAr $yearAr';
  final dates =
      " $formattedHijriDate -  $dayEn $monthEn $yearEn";

  return dates.toString();
}

String eventDate(String date) {
    final now = DateTime.parse(date);

    // hijri date
    final hDate = HijriCalendar.fromDate(now);
    HijriCalendar.language = 'en';
    final dayAr = hDate.toFormat('dd');
    final yearAr = hDate.toFormat('yyyy');
    

    HijriCalendar.language = 'ar';
    final monthAr = hDate.toFormat('MMMM');

    // miladi date
    final dayEn = DateFormat('dd', 'en').format(now);
    final yearEn = DateFormat('yyyy', 'en').format(now);
    final monthEn = DateFormat('MMMM', 'ar').format(now);

    // day name
    final dayName = DateFormat('EEEE', 'ar').format(now);
  final String formattedHijriDate =
      '$dayAr $monthAr $yearAr';
  final dates =
      "  $dayName $dayEn $monthEn $yearEn - $formattedHijriDate ";

  return dates.toString();
}

class CustomDates {
  DateTime now = DateTime.now();

  dateInDayes(String date) {
    var eventDate = parseDate(date);

    final int days = eventDate.difference(now).inDays;
    if (days <= 0) {
      return defultEnd;
    }
    return days.toString();
  }

  dateInHours(String date) {
    var eventDate = parseDate(date);

    final int hours = eventDate.difference(now).inHours % 24;
    if (hours <= 0) {
      return defultEnd;
    }
    return hours.toString();
  }

  dateInMinutes(String date) {
    var eventDate = parseDate(date);

    final int minutes = eventDate.difference(now).inMinutes % 60;
    if (minutes <= 0) {
      return defultEnd;
    }

    return minutes.toString();
  }

  dateInSeconds(String date) {
    var eventDate = parseDate(date);

    final int seconds = eventDate.difference(now).inSeconds % 60;
    if (seconds <= 0) {
      return defultEnd;
    }
    return seconds.toString();
  }
}

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
const defultEnd = "End";