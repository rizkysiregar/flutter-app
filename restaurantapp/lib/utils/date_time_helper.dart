import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    /// Date and Time Format
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    /// Today Format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // Tommorow Format
    var formatted = resultToday.add(const Duration(days: 1));
    final tommorowDate = dateFormat.format(formatted);
    final tommorowDateAndTime = "$tommorowDate $timeSpecific";
    var resultTommorow = completeFormat.parseStrict(tommorowDateAndTime);

    return now.isAfter(resultToday) ? resultTommorow : resultToday;
  }
}
