import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/extension.dart';

class Helper {
  static double widthScreen(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double heightScreen(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static void get closeKeyboard =>
      FocusManager.instance.primaryFocus?.unfocus();

  static bool detectScrolledToEnd(ScrollController scrollController) {
    return scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 48;
  }

  static Future<void> showCalendarPickerHelper({
    required BuildContext context,
    required List<DateTime?> initialDates,
    required void Function(List<DateTime?> selectedDates) onDateSelected,
  }) async {
    final result = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        selectedDayHighlightColor: BaseColor.blue,
        daySplashColor: BaseColor.softBlue,
      ),
      dialogSize: const Size(325, 400),
      value: initialDates,
      borderRadius: BorderRadius.circular(15),
    );

    if (result != null && result.isNotEmpty) {
      onDateSelected(result);
    }
  }

  static Future<void> showDateTimePickerHelper({
    required BuildContext context,
    required DateTime? initialDate,
    required void Function(DateTime selectedDateTime) onDateTimeSelected,
  }) async {
    final dateResult = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        selectedDayHighlightColor: BaseColor.blue,
        daySplashColor: BaseColor.softBlue,
      ),
      dialogSize: const Size(325, 400),
      value: [initialDate],
      borderRadius: BorderRadius.circular(15),
    );

    if (dateResult == null || dateResult.isEmpty || dateResult.first == null) {
      return; 
    }

    DateTime selectedDate = dateResult.first!;

    final timeOfDay = await showTimePicker(
      context: context,
      
      initialTime: TimeOfDay.fromDateTime(initialDate ?? DateTime.now()),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              dialHandColor: BaseColor.blue,
              dialBackgroundColor: BaseColor.softBlue,
              confirmButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(BaseColor.blue),
              ),
              cancelButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(BaseColor.grey2),
              ),
              
            ),
          ),
          child: child!,
        );
      },
    );

    if (timeOfDay != null) {
      final selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
      onDateTimeSelected(selectedDateTime);
    }
  }

  static String timeAgoSinceDate(
    String dateTimeZone, {
    bool numericDates = true,
  }) {
    DateTime notificationDate;

    try {
      if (dateTimeZone.isNum) {
        notificationDate = DateTime.fromMillisecondsSinceEpoch(
          int.parse(dateTimeZone) * 1000,
        );
      } else {
        notificationDate =
            dateTimeZone != '' ? DateTime.parse(dateTimeZone) : DateTime.now();
      }
    } catch (e) {
      return dateTimeZone;
    }

    final dateNow = DateTime.now();
    final difference = dateNow.difference(notificationDate);

    if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 30).floor()} bulan';
    }
    if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 bulan' : 'Bulan';
    }
    if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} minggu';
    }
    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 minggu' : 'Minggu';
    }
    if (difference.inDays >= 2) {
      return '${difference.inDays} hari';
    }
    if (difference.inDays >= 1) {
      return (numericDates) ? '1 hari' : 'Kemarin';
    }
    if (difference.inHours >= 2) {
      return '${difference.inHours} jam';
    }
    if (difference.inHours >= 1) {
      return (numericDates) ? '1 jam' : 'Beberapa jam';
    }
    if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} menit';
    }
    if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 menit' : 'Beberapa menit';
    }
    if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} detik';
    }

    return 'Sekarang';
  }
}
