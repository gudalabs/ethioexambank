import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String formatValidityDate(String dateString) {
    var inputDate = DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateString);
    var outputFormat = DateFormat('dd MMM yyyy').format(inputDate);
    return outputFormat;
  }

  static String isoToLocalDateAndTime(String dateTime, {String errorResult = '--'}) {
    String date = '';
    if (dateTime.isEmpty || dateTime == 'null') {
      date = '';
    }
    try {
      date = DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
    } catch (v) {
      date = '';
    }
    String time = isoStringToLocalTimeOnly(dateTime);
    return '$date, $time';
  }

  static String formatDepositTimeWithAmFormat(String dateString) {
    var newStr = '${dateString.substring(0, 10)} ${dateString.substring(11, 23)}';
    DateTime dt = DateTime.parse(newStr);

    String formatedDate = DateFormat("yyyy-MM-dd").format(dt);

    return formatedDate;
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    //return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
    return DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").parse(dateTime);
  }

  static String convertIsoToString(String dateTime) {
    DateTime time = convertStringToDatetime(dateTime);
    String result = DateFormat(
      'dd MMM yyyy hh:mm aa',
    ).format(time);
    return result;
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoToLocalTimeSubtract(String dateTime) {
    DateTime date = isoStringToLocalDate(dateTime);
    final currentDate = DateTime.now();
    final difference = currentDate.difference(date).inDays;
    return difference.toString();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    try {
      return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
    } catch (v) {
      return "--";
    }
  }

  static String isoStringToLocalFormattedDateOnly(String dateTime) {
    try {
      return DateFormat('dd MMM, yyyy').format(isoStringToLocalDate(dateTime));
    } catch (v) {
      return "--";
    }
  }

  static String isoStringToLocalFormattedDateAndTimeOnly(String dateTime) {
    try {
      return DateFormat('d MMM, yyyy h:mm a').format(isoStringToLocalDate(dateTime));
    } catch (v) {
      return "--";
    }
  }

  static String localDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime.toUtc());
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }

  static String nextReturnTime(String dateTime) {
    final date = DateFormat("dd MMM, yyyy hh:mm a").format(DateTime.parse(dateTime));
    return date;
  }

  static String getFormatedSubtractTime(String time, {bool numericDates = false}) {
    final date1 = DateTime.now();
    final isoDate = isoStringToLocalDate(time);
    final difference = date1.difference(isoDate);

    if ((difference.inDays / 365).floor() >= 1) {
      int year = (difference.inDays / 365).floor();
      return '$year year ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      int month = (difference.inDays / 30).floor();
      return '$month month ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      int week = (difference.inDays / 7).floor();
      return '$week week ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static String stringDateToDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    final DateFormat outputFormat = DateFormat('d MMM yyyy');
    return outputFormat.format(date);
  }

  int calculateDurationToEndTime(String endTime) {
    // Get the current time
    DateTime currentTime = DateTime.now();

    // Split the endTime string into hours and minutes
    List<String> timeComponents = endTime.split(':');
    int endHour = int.parse(timeComponents[0]);
    int endMinute = int.parse(timeComponents[1].split(' ')[0]);
    String amPm = timeComponents[1].split(' ')[1].toLowerCase();

    if (amPm == 'pm' && endHour != 12) {
      endHour += 12;
    } else if (amPm == 'am' && endHour == 12) {
      endHour = 0;
    }

    // Create a DateTime object for the specified end time
    DateTime parsedEndTime = DateTime(currentTime.year, currentTime.month, currentTime.day, endHour, endMinute);

    // Calculate the time difference
    Duration difference = parsedEndTime.difference(currentTime);

    // Convert the time difference to minutes
    int durationInMinutes = difference.inMinutes;

    return durationInMinutes;
  }

  static String formatDateTime(String inputString, String format) {
    try {
      // Parse the input date and time string
      final inputDateTime = DateTime.parse(inputString);

      // Create a date and time format
      final formatter = DateFormat(format);

      // Format the date and time and return the formatted string
      return formatter.format(inputDateTime);
    } catch (e) {
      // Handle any parsing errors here
      return "Invalid Date/Time";
    }
  }
}
