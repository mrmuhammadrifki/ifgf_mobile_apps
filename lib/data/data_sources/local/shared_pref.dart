import 'dart:convert';

import 'package:ifgf_apps/data/models/detail_profile_response.dart';
import 'package:ifgf_apps/data/models/login_response.dart';
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

  static LoginResponse? get loginResponse {
    try {
      return LoginResponse.fromMap(
          jsonDecode(_sharedPrefs.getString(_keySignIn) ?? ''));
    } catch (e) {
      return null;
    }
  }

  static set loginResponse(LoginResponse? value) {
    _sharedPrefs.setString(_keySignIn, jsonEncode(value?.toMap()));
  }

  static DetailProfileResponse? get detailProfileResponse {
    try {
      return DetailProfileResponse.fromMap(
          jsonDecode(_sharedPrefs.getString(_keyDetailProfile) ?? ''));
    } catch (e) {
      return null;
    }
  }

  static set detailProfileResponse(DetailProfileResponse? value) {
    _sharedPrefs.setString(_keyDetailProfile, jsonEncode(value?.toMap()));
  }
}

const String _keySignIn = "sign_in";
const String _keyDetailProfile = "detail_profile";
