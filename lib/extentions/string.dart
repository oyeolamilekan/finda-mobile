import 'dart:convert';

import 'package:intl/intl.dart';

extension StringExtension on String {
  /// Simple Utility extensions to simplify work speed.

  bool validateEmail() {
    /// Checks if the string is a valid email address
    const String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final RegExp regExp = RegExp(p);

    return regExp.hasMatch(this);
  }

  bool strip() {
    return replaceAll(RegExp(r"\s+"), "").isEmpty;
  }

  String slugify() {
    /// Converts String to slug
    return trim().replaceAll(".", "-").replaceAll(" ", "-");
  }

  String turnStringToDate(String format) {
    /// Converts Dates into string
    return DateFormat(format).format(DateTime.parse(this)).toString();
  }

  String capitalize() {
    /// Capitalize the first index of the string
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get utf8Convert {
    final List<int> bytes = codeUnits;
    return utf8.decode(bytes);
  }
}
