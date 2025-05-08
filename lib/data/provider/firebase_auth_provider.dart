import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/local/shared_pref.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_auth_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/profile_firestore_service.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:ifgf_apps/data/models/login_response.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuthService _authService;
  final ProfileFirestoreService _firestoreService;

  FirebaseAuthProvider(this._authService, this._firestoreService);

  Future<DataState<bool>> signUp({
    String? email,
    String? password,
    String? fullName,
    DateTime? birthDate,
    String? phoneNumber,
    bool? isAdmin,
    ImageResponse? photoProfile,
  }) async {
    try {
      final result = await _authService.createUser(email, password);
      final uid = result.user?.uid;

      if (uid == null) {
        return const DataFailed('Gagal mendapatkan user ID.');
      }

      await _firestoreService.saveProfile(
        uid: uid,
        fullName: fullName ?? "",
        birthDate: birthDate ?? DateTime.now(),
        phoneNumber: phoneNumber ?? "",
        isAdmin: isAdmin,
        photoProfile: photoProfile,
        email: email,
      );

      return const DataSuccess(true);
    } catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<UserCredential>> signIn({
    String? email,
    String? password,
  }) async {
    try {
      final result = await _authService.signInUser(email, password);
      final user = result.user;

      if (user == null || user.uid.isEmpty) {
        return const DataFailed('Gagal mendapatkan user ID.');
      }

      SharedPref.loginResponse = LoginResponse(
        email: user.email,
        name: user.displayName,
        photoUrl: user.photoURL,
      );

      final detailProfileResponse =
          await _firestoreService.getDetailProfile(user.uid);

      if (detailProfileResponse.id.isNotEmpty) {
        SharedPref.detailProfileResponse = detailProfileResponse;
      }

      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<bool>> signOut() async {
    try {
      await _authService.signOut();

      return const DataSuccess(true);
    } catch (e) {
      return DataFailed(e);
    }
  }
}
