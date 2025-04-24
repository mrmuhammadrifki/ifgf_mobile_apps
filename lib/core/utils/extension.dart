import 'package:ifgf_apps/core/utils/regex.dart';
import 'package:intl/intl.dart';

extension DateFormatting on String {
  String get formattedDate {
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
    } catch (e) {
      return this;
    }
  }

  String get formattedDateTime {
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat('d MMMM yyyy, HH.mm', 'id_ID').format(dateTime);
    } catch (e) {
      return this;
    }
  }

  String get formattedDate2 {
    try {
      DateTime parsedDate = DateTime.parse(this);
      return DateFormat("E, d MMM y").format(parsedDate);
    } catch (e) {
      return this;
    }
  }
}

extension DateTimeExt on DateTime {
  String get formattedDate => DateFormat('d MMMM yyyy').format(this);
}

extension StringExt on String {
  String capitalize() {
    if (isEmpty) return "";

    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  bool get isNum {
    return num.tryParse(this) is num;
  }

  String get getInitials => isNotEmpty
      ? trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';

  bool isValidEmail() {
    return Regex.email.hasMatch(this);
  }

  bool isEmptyWithTrim() {
    return trim().isEmpty;
  }
}
