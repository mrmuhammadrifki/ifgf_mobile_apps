
import 'package:flutter/material.dart';
import 'package:ifgf_apps/data/data_sources/local/shared_pref.dart';
import 'package:ifgf_apps/data/models/detail_profile_response.dart';

class ProfileProvider extends ChangeNotifier {
  DetailProfileResponse? _profile;
  DetailProfileResponse? get profile => _profile;

  void reload() {
    _profile = SharedPref.detailProfileResponse;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void showLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
