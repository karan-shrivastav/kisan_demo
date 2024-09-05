import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTimestamp(String timestampString) {
    DateTime dateTime = DateTime.parse(timestampString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
