import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Inter',
    primaryColor: BaseColor.softBlue,
    primaryColorDark: BaseColor.softBlue,
    primaryColorLight: BaseColor.softBlue,
    focusColor: BaseColor.softBlue,
    indicatorColor: BaseColor.softBlue,
    disabledColor: BaseColor.disable,
    hintColor: BaseColor.hint,
    colorScheme: const ColorScheme.light(error: BaseColor.danger),
    cardColor: BaseColor.white,
    appBarTheme: _appBarTheme,
    elevatedButtonTheme: _elevatedButtonThemeData,
    outlinedButtonTheme: _outlinedButtonThemeData,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme,
    bottomNavigationBarTheme: _bottomNavigationBarThemeData,
    tabBarTheme: _tabBarTheme,
    snackBarTheme: _snackBarThemeData,
    checkboxTheme: _checkboxTheme,
    progressIndicatorTheme: _progressIndicatorThemeData,
    textSelectionTheme: _textSelectionThemeData,
  );
}

AppBarTheme _appBarTheme = const AppBarTheme(
  elevation: 0,
  backgroundColor: BaseColor.white,
  titleTextStyle: TextStyle(
    color: BaseColor.text,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  ),
  toolbarHeight: 61,
  iconTheme: IconThemeData(color: BaseColor.black, size: 26),
  actionsIconTheme: IconThemeData(color: BaseColor.black, size: 26),
  scrolledUnderElevation: 0,
);

ElevatedButtonThemeData _elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.pressed)) {
        return BaseColor.blue;
      }

      if (states.contains(WidgetState.disabled)) {
        return BaseColor.disable;
      }

      return BaseColor.blue; // Use the component's default.
    }),
    overlayColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.pressed)) {
        return BaseColor.white.withOpacity(0.05);
      }

      if (states.contains(WidgetState.disabled)) {
        return BaseColor.disable;
      }

      return BaseColor.white.withOpacity(0.05);
    }),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    foregroundColor: const WidgetStatePropertyAll(Color(0xffF0F0F0)),
    textStyle: WidgetStatePropertyAll(
      GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
);

OutlinedButtonThemeData _outlinedButtonThemeData = OutlinedButtonThemeData(
  style: ButtonStyle(
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.pressed)) {
        return BaseColor.white;
      }

      if (states.contains(WidgetState.disabled)) {
        return BaseColor.disable;
      }

      return BaseColor.white; // Use the component's default.
    }),
    overlayColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.pressed)) {
        return BaseColor.softBlue.withOpacity(0.05);
      }

      if (states.contains(WidgetState.disabled)) {
        return BaseColor.disable;
      }

      return BaseColor.softBlue.withOpacity(0.05);
    }),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    side: const WidgetStatePropertyAll(BorderSide(color: BaseColor.softBlue)),
    foregroundColor: const WidgetStatePropertyAll(BaseColor.softBlue),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),
);

TextTheme _textTheme = const TextTheme(
  displayLarge: TextStyle(
    color: BaseColor.text,
    fontSize: 57,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
  ),
  displayMedium: TextStyle(
    color: BaseColor.text,
    fontSize: 45,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
  ),
  displaySmall: TextStyle(
    color: BaseColor.text,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
  ),
  headlineLarge: TextStyle(
    color: BaseColor.text,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
  ),
  headlineMedium: TextStyle(
    color: BaseColor.text,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
  ),
  headlineSmall: TextStyle(
    color: BaseColor.text,
    fontSize: 24,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
  ),
  titleLarge: TextStyle(
    color: BaseColor.text,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  ),
  titleMedium: TextStyle(
    color: BaseColor.text,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  ),
  titleSmall: TextStyle(
    color: BaseColor.text,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  ),
  labelLarge: TextStyle(
    color: BaseColor.text,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  ),
  labelMedium: TextStyle(
    color: BaseColor.text,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  ),
  labelSmall: TextStyle(
    color: BaseColor.text,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  ),
  bodyLarge: TextStyle(
    color: BaseColor.text,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  ),
  bodyMedium: TextStyle(
    color: BaseColor.text,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  ),
  bodySmall: TextStyle(
    color: BaseColor.text,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  ),
);

InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  filled: true,
  fillColor: BaseColor.white,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 1, color: BaseColor.border),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 1, color: BaseColor.softBlue),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 1, color: BaseColor.danger),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 1, color: BaseColor.danger),
  ),
  hintStyle: const TextStyle(
    color: BaseColor.hint,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  errorStyle: const TextStyle(
    color: BaseColor.danger,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  isDense: true,
);

BottomNavigationBarThemeData _bottomNavigationBarThemeData =
    BottomNavigationBarThemeData(
  backgroundColor: BaseColor.white,
  type: BottomNavigationBarType.fixed,
  selectedItemColor: BaseColor.blue,
  selectedLabelStyle: GoogleFonts.poppins(
    color: BaseColor.softBlue,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  unselectedItemColor: BaseColor.unSelect,
  unselectedLabelStyle: GoogleFonts.poppins(
    color: BaseColor.grey2,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
);

TabBarTheme _tabBarTheme = TabBarTheme(
  labelColor: BaseColor.text,
  indicatorColor: BaseColor.softBlue,
  unselectedLabelColor: const Color(0xff909090),
  dividerColor: const Color(0xffF3F3F3),
  dividerHeight: 3,
  indicatorSize: TabBarIndicatorSize.tab,
  overlayColor: WidgetStateProperty.resolveWith<Color>((
    Set<WidgetState> states,
  ) {
    if (states.contains(WidgetState.pressed)) {
      return BaseColor.softBlue.withOpacity(0.05);
    }

    if (states.contains(WidgetState.disabled)) {
      return BaseColor.disable;
    }

    return BaseColor.softBlue.withOpacity(0.05);
  }),
  indicator: const UnderlineTabIndicator(
    // color for indicator (underline)
    borderSide: BorderSide(color: BaseColor.softBlue, width: 3),
  ),
  labelStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: BaseColor.text,
  ),
  unselectedLabelStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: BaseColor.text,
  ),
);

SnackBarThemeData _snackBarThemeData = SnackBarThemeData(
  showCloseIcon: true,
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  contentTextStyle: TextStyle(
    fontSize: 12,
    color: BaseColor.grey.shade900,
    fontWeight: FontWeight.w400,
  ),
  backgroundColor: BaseColor.green.shade100,
  closeIconColor: BaseColor.green.shade800,
  insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
);

CheckboxThemeData _checkboxTheme = CheckboxThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
  side: WidgetStateBorderSide.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return const BorderSide(color: BaseColor.softBlue, width: 1);
    }

    if (states.contains(WidgetState.disabled)) {
      return BorderSide(color: BaseColor.grey.shade500, width: 2);
    }

    return const BorderSide(color: BaseColor.grey, width: 1);
  }),
  fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return BaseColor.softBlue;
    }

    if (states.contains(WidgetState.disabled)) {
      return BaseColor.grey.shade500;
    }

    return BaseColor.grey.shade500; // Use the component's default.
  }),
);

ProgressIndicatorThemeData _progressIndicatorThemeData =
    const ProgressIndicatorThemeData(color: BaseColor.softBlue);

TextSelectionThemeData _textSelectionThemeData = TextSelectionThemeData(
  cursorColor: BaseColor.softBlue,
  selectionColor: BaseColor.softBlue,
  selectionHandleColor: BaseColor.softBlue,
);
