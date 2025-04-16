class Regex {
  static RegExp email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static RegExp alphaNumericSpace =
      RegExp(r'^[A-Za-z0-9 ]*[A-Za-z0-9][A-Za-z0-9 ]*$');

  static RegExp numericDot = RegExp(r'^(?!$)[\d.]+$');

  static RegExp numeric = RegExp(r'^\d+$');
}
