import 'package:flutter/material.dart';

base class BaseColor {
  static const Color black = Color(0xff292D42);
  static const Color black2 = Color(0xff0F172A);
  static const Color white = Color(0xffFFFFFF);

  static const Color blue = Color(0xff3777C0);
  static const Color softBlue = Color(0xffCCDDF2);
  static const Color orange = Color(0xffFCB72E);
  static const Color grey2 = Color(0xff969696);
  static const Color darkGreen = Color(0xff00723D);
  static const Color text = Color(0xff070629);
  static const Color border = Color(0xffD9D9D9);
  static const Color hint = Color(0xff94A3B8);
  static const Color disable = Color(0xffB6B6B6);
  static const Color unSelect = Color(0xff9B9B9B);
  static const Color subtitle = Color(0xff64748B);

  static const Color success = Color(0xff28A745);
  static const Color danger = Color(0xffDC3545);
  static const Color warning = Color(0xffFFC107);
  static const Color info = Color(0xff636A79);
  static const Color icon = Color(0xff636A79);

  static const int _greyPrimaryValue = 0xff59636B;
  static const MaterialColor grey =
      MaterialColor(_greyPrimaryValue, <int, Color>{
    100: Color(0xFFF8F9FA),
    200: Color(0xFFE9ECEF),
    300: Color(0xFFDEE2E6),
    400: Color(0xFFCED4DA),
    500: Color(_greyPrimaryValue),
    600: Color(0xFF6C757D),
    700: Color(0xFF495057),
    800: Color(0xFF343A40),
    900: Color(0xFF212529),
  });

  static const int _redPrimaryValue = 0xFFDC3545;
  static const MaterialColor red = MaterialColor(_redPrimaryValue, <int, Color>{
    100: Color(0xFFF8D7DA),
    200: Color(0xFFF1AEB5),
    300: Color(0xFFEA868F),
    400: Color(0xFFE35D6A),
    500: Color(_redPrimaryValue),
    600: Color(0xFFB02A37),
    700: Color(0xFF842029),
    800: Color(0xFF58151C),
    900: Color(0xFF2C0B0E),
  });

  static const int _yellowPrimaryValue = 0xFFFFC107;
  static const MaterialColor yellow =
      MaterialColor(_yellowPrimaryValue, <int, Color>{
    100: Color(0xFFFFF3CD),
    200: Color(0xFFFFE69C),
    300: Color(0xFFFFDA6A),
    400: Color(0xFFFFCD39),
    500: Color(_yellowPrimaryValue),
    600: Color(0xFFCC9A06),
    700: Color(0xFF997404),
    800: Color(0xFF664D03),
    900: Color(0xFF332701),
  });

  static const int _greenPrimaryValue = 0xFF198754;
  static const MaterialColor green =
      MaterialColor(_greenPrimaryValue, <int, Color>{
    100: Color(0xFFD1E7DD),
    200: Color(0xFFA3CFBB),
    300: Color(0xFF75B798),
    400: Color(0xFF479F76),
    500: Color(_greenPrimaryValue),
    600: Color(0xFF146C43),
    700: Color(0xFF0F5132),
    800: Color(0xFF0A3622),
    900: Color(0xFF051B11),
  });
}
