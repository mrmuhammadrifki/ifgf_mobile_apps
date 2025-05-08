import 'package:ifgf_apps/data/models/image_response.dart';

class DetailProfileResponse {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String birthDate;
  final bool isAdmin;
  final String createdAt;
  final String email;
  List<ImageResponse?>? photoProfile;

  DetailProfileResponse({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.birthDate,
    required this.isAdmin,
    required this.createdAt,
    required this.email,
    this.photoProfile,
  });

  factory DetailProfileResponse.fromMap(Map<String, dynamic> map) {
    return DetailProfileResponse(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      birthDate: map['birth_date'] ?? '',
      isAdmin: map['is_admin'] ?? false,
      createdAt: map['created_at'] ?? '',
      email: map['email'] ?? '',
      photoProfile: (map['photo_profile'] as List<dynamic>)
          .map((e) => ImageResponse.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'birth_date': birthDate,
      'is_admin': isAdmin,
      'created_at': createdAt,
      'email': email,
      'photo_profile': photoProfile?.map((e) => e?.toMap()).toList(),
    };
  }

  DetailProfileResponse copyWith({
  String? id,
  String? fullName,
  String? phoneNumber,
  String? birthDate,
  bool? isAdmin,
  String? createdAt,
  String? email,
  List<ImageResponse?>? photoProfile,
}) {
  return DetailProfileResponse(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    birthDate: birthDate ?? this.birthDate,
    isAdmin: isAdmin ?? this.isAdmin,
    createdAt: createdAt ?? this.createdAt,
    email: email ?? this.email,
    photoProfile: photoProfile ?? this.photoProfile,
  );
}

}
