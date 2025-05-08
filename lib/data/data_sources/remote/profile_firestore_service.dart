import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/data/models/detail_profile_response.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:ifgf_apps/data/repository/profile_repository.dart';

class ProfileFirestoreService implements ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProfileFirestoreService(
    FirebaseFirestore? firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore ??= FirebaseFirestore.instance;

  @override
  Future<void> saveProfile({
    required String uid,
    required String fullName,
    required DateTime birthDate,
    required String phoneNumber,
    bool? isAdmin,
    ImageResponse? photoProfile,
    String? email,
  }) async {
    try {
      photoProfile ??= ImageResponse(url: "", filePath: "");
      await _firebaseFirestore.collection('users').doc(uid).set({
        'id': uid,
        'full_name': fullName,
        'birth_date': birthDate.toIso8601String(),
        'phone_number': phoneNumber,
        'is_admin': isAdmin ?? false,
        'created_at': DateTime.now().toIso8601String(),
        'photo_profile': [photoProfile.toJson()],
        'email': email,
      });
    } on FirebaseException catch (e) {
      throw Exception('Gagal menyimpan data user: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menyimpan data user: ${e.toString()}');
    }
  }

  @override
  Future<DetailProfileResponse> getDetailProfile(String uid) async {
    try {
      final doc = await _firebaseFirestore.collection('users').doc(uid).get();

      final data = doc.data();
      if (doc.exists && data != null) {
        debugPrint(doc.data().toString());
        return DetailProfileResponse.fromMap(data);
      } else {
        throw Exception('User dengan ID $uid tidak ditemukan.');
      }
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data user: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data user: ${e.toString()}');
    }
  }

  Future<List<DetailProfileResponse>> getListJemaat({String? uid}) async {
    try {
      final querySnapshot = await _firebaseFirestore.collection('users').get();

      final listJemaat = querySnapshot.docs.map((doc) {
        return DetailProfileResponse.fromMap(doc.data());
      }).toList();

      listJemaat.sort(
        (a, b) => DateTime.parse(b.createdAt).compareTo(
          DateTime.parse(a.createdAt),
        ),
      );

      return listJemaat;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data jemaat: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data jemaat: ${e.toString()}');
    }
  }

  @override
  Future<void> updateProfile({
    String? uid,
    String? fullName,
    DateTime? birthDate,
    String? phoneNumber,
    bool? isAdmin,
    ImageResponse? photoProfile,
  }) async {
    try {
      final docRef = _firebaseFirestore.collection('users').doc(uid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final updateData = <String, dynamic>{};

        if (fullName != null) updateData['full_name'] = fullName;
        if (birthDate != null) {
          updateData['birth_date'] = birthDate.toIso8601String();
        }
        if (phoneNumber != null) updateData['phone_number'] = phoneNumber;
        if (isAdmin != null) updateData['is_admin'] = isAdmin;
        if (photoProfile != null) {
          updateData['photo_profile'] = [photoProfile.toJson()];
        }

        await docRef.update(updateData);
      } else {
        throw Exception('Data jemaat dengan id $uid tidak ditemukan.');
      }
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengupdate data jemaat: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengupdate data jemaat: ${e.toString()}');
    }
  }
}
