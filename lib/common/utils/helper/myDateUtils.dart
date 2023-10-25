import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class MyDateUtils {
  static String getFormatedTime(Timestamp timestamp) {
    final date = timestamp.toDate();

    print(date);

    // if(date == DateTime.no)
    //   {
    //
    //   }

    return date.toString();
  }

  // Function to format timestamp
  static String formatTimestamp(DateTime getTime) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (now.year == getTime.year &&
        now.month == getTime.month &&
        now.day == getTime.day) {
      // It's today
      return formatDate(getTime, [h, ":", nn, " ", am]);
    } else if (yesterday.year == getTime.year &&
        yesterday.month == getTime.month &&
        yesterday.day == getTime.day) {
      // It's yesterday
      // return 'Yesterday ${DateFormat.jm().format(getTime)}'; // Format time with AM/PM
      return formatDate(getTime, ["Yesterday", ", ", h, ":", nn, " ", am]);
    } else {
      // Display date and month
      return formatDate(getTime, [d, " ", M]);
    }
  }
}
