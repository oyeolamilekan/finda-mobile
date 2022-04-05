import 'package:intl/intl.dart';

String parseDateToString(String date) {
  final String dateval =
      DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.parse(date));
  return dateval;
}
