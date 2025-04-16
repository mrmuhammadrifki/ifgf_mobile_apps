import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _sharedPrefs;

  factory SharedPref() => _instance;

  static final SharedPref _instance = SharedPref._internal();

  SharedPref._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  void clear() {
    _sharedPrefs.clear();
  }

  Future<void> reload() async {
    await _sharedPrefs.reload();
  }

  // static LoginResponse? get loginResponse {
  //   try {
  //     return LoginResponse.fromMap(
  //       jsonDecode(_sharedPrefs.getString(_keySignIn) ?? ''),
  //     );
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static set loginResponse(LoginResponse? value) {
  //   _sharedPrefs.setString(_keySignIn, jsonEncode(value?.toMap()));
  // }

  // static ProfileResponse? get profileResponse {
  //   try {
  //     return ProfileResponse.fromMap(
  //       jsonDecode(_sharedPrefs.getString(_keyProfile) ?? ''),
  //     );
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static set profileResponse(ProfileResponse? value) {
  //   _sharedPrefs.setString(_keyProfile, jsonEncode(value?.toMap()));
  // }
}

const String _keySignIn = "sign_in";
const String _keyProfile = "profile";
