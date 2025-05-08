import 'package:ifgf_apps/data/models/detail_profile_response.dart';
import 'package:ifgf_apps/data/models/image_response.dart';

abstract class ProfileRepository {
  Future<void> saveProfile({
    required String uid,
    required String fullName,
    required DateTime birthDate,
    required String phoneNumber,
    bool? isAdmin,
    ImageResponse? photoProfile,
  });
  Future<DetailProfileResponse> getDetailProfile(String uid);
    Future<void> updateProfile({
    required String uid,
    required String fullName,
    required DateTime birthDate,
    required String phoneNumber,
    bool? isAdmin,
    ImageResponse? photoProfile,
  });
}
