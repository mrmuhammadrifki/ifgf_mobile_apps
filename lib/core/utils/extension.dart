import 'package:ifgf_apps/core/utils/regex.dart';
import 'package:intl/intl.dart';

extension RupiahFormatter on String {
  String toRupiah() {
    try {
      // Menghapus semua karakter selain angka dan tanda minus
      final cleaned = replaceAll(RegExp(r'[^0-9\-]'), '');
      final number = num.tryParse(cleaned);
      if (number == null) return this;

      final absNumber = number.abs();
      String formatted;

      if (absNumber >= 1000000000) {
        // Format untuk miliar (M)
        formatted = '${(absNumber / 1000000000).toStringAsFixed(1)} M';
      } else {
        final formatter = NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp ',
          decimalDigits: 0,
        );
        formatted = formatter.format(absNumber);
      }

      // Menambahkan tanda minus jika angka asli negatif
      return number < 0 ? '-$formatted' : formatted;
    } catch (e) {
      return this;
    }
  }
}

extension DateFormatting on String {
  String get formattedMonthYear {
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat('MMMM yyyy', 'id_ID').format(dateTime);
    } catch (e) {
      return this;
    }
  }

  String get formattedDate {
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
    } catch (e) {
      return this;
    }
  }

  String formattedDayDateTime() {
    try {
      final date = DateTime.parse(this);
      return DateFormat("EEEE, d MMMM y, HH.mm", "id_ID").format(date);
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
