import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/data/models/member_discipleship_journey_response.dart';
import 'package:ifgf_apps/data/models/member_icare_response.dart';
import 'package:uuid/uuid.dart';

class RegisterFirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  RegisterFirestoreService(
    FirebaseFirestore? firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore ??= FirebaseFirestore.instance;

  Future<void> registerDiscipleshipJourney({
    String? fullName,
    String? jenisDiscipleshipJourney,
    String? birthDate,
    String? age,
    String? phone,
  }) async {
    try {
      final String memberIcareId = const Uuid().v4();
      await _firebaseFirestore
          .collection('discipleship_journey_members')
          .doc(memberIcareId)
          .set({
        'id': memberIcareId,
        'full_name': fullName,
        'jenis_discipleship_journey': jenisDiscipleshipJourney,
        'birth_date': birthDate,
        'created_at': DateTime.now().toIso8601String(),
        'age': age,
        'phone': phone,
      });
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal daftar discipleship journey: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal daftar discipleship journey: ${e.toString()}');
    }
  }

  Future<void> registerIcare({
    String? fullName,
    String? jenisIcare,
    String? birthDate,
    String? age,
    String? phone,
  }) async {
    try {
      final String memberIcareId = const Uuid().v4();
      await _firebaseFirestore
          .collection('icare_members')
          .doc(memberIcareId)
          .set({
        'id': memberIcareId,
        'full_name': fullName,
        'jenis_icare': jenisIcare,
        'birth_date': birthDate,
        'created_at': DateTime.now().toIso8601String(),
        'age': age,
        'phone': phone,
      });
    } on FirebaseException catch (e) {
      throw Exception('Gagal daftar icare: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal daftar icare: ${e.toString()}');
    }
  }

  Future<List<MemberIcareResponse>> getListMemberIcare() async {
    try {
      final querySnapshot =
          await _firebaseFirestore.collection('icare_members').get();

      final listMemberIcare = querySnapshot.docs.map((doc) {
        debugPrint(doc.data().toString());
        return MemberIcareResponse.fromMap(doc.data());
      }).toList();

      listMemberIcare.sort(
        (a, b) => DateTime.parse(b.createdAt ?? "").compareTo(
          DateTime.parse(a.createdAt ?? ""),
        ),
      );

      return listMemberIcare;
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal mengambil data member icare: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data member icare: ${e.toString()}');
    }
  }

  Future<List<MemberDiscipleshipJourneyResponse>>
      getListMemberDiscipleshipJourney() async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('discipleship_journey_members')
          .get();

      final listMemberIcare = querySnapshot.docs.map((doc) {
        debugPrint(doc.data().toString());
        return MemberDiscipleshipJourneyResponse.fromMap(doc.data());
      }).toList();

      listMemberIcare.sort(
        (a, b) => DateTime.parse(b.createdAt ?? "").compareTo(
          DateTime.parse(a.createdAt ?? ""),
        ),
      );

      return listMemberIcare;
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal mengambil data member discipleship jouney: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception(
          'Gagal mengambil data member discipleship jouney: ${e.toString()}');
    }
  }

  Future<MemberIcareResponse?> getOneMemberIcare({String? id}) async {
    try {
      final docSnapshot =
          await _firebaseFirestore.collection('icare_members').doc(id).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          debugPrint(data.toString());
          return MemberIcareResponse.fromMap(data);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil member icare: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil member icare: ${e.toString()}');
    }
  }

  Future<void> updateMemberIcare({
    required String id,
    String? fullName,
    String? jenisIcare,
    String? birthDate,
    String? age,
    String? phone,
  }) async {
    try {
      final docRef = _firebaseFirestore.collection('icare_members').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final updateData = <String, dynamic>{};

        if (fullName != null) updateData['full_name'] = fullName;
        if (jenisIcare != null) updateData['jenis_icare'] = jenisIcare;
        if (birthDate != null) updateData['birth_date'] = birthDate;
        if (age != null) updateData['age'] = age;
        if (phone != null) updateData['phone'] = phone;

        await docRef.update(updateData);
      } else {
        throw Exception('Data member icare dengan id $id tidak ditemukan.');
      }
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal mengupdate member icare: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengupdate member icare: ${e.toString()}');
    }
  }

  Future<MemberDiscipleshipJourneyResponse?> getOneMemberDiscipleshipJourney(
      {String? id}) async {
    try {
      final docSnapshot = await _firebaseFirestore
          .collection('discipleship_journey_members')
          .doc(id)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          debugPrint(data.toString());
          return MemberDiscipleshipJourneyResponse.fromMap(data);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal mengambil member discipleship journey: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception(
          'Gagal mengambil member discipleship journey: ${e.toString()}');
    }
  }

  Future<void> updateMemberDiscipleshipJourney({
    required String id,
    String? fullName,
    String? jenisDiscipleshipJourney,
    String? birthDate,
    String? age,
    String? phone,
  }) async {
    try {
      final docRef = _firebaseFirestore.collection('discipleship_journey_members').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final updateData = <String, dynamic>{};

        if (fullName != null) updateData['full_name'] = fullName;
        if (jenisDiscipleshipJourney != null) {
          updateData['jenis_discipleship_journey'] = jenisDiscipleshipJourney;
        }
        if (birthDate != null) updateData['birth_date'] = birthDate;
        if (age != null) updateData['age'] = age;
        if (phone != null) updateData['phone'] = phone;

        await docRef.update(updateData);
      } else {
        throw Exception(
            'Data member discipleship journey dengan id $id tidak ditemukan.');
      }
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal mengupdate member discipleship journey: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception(
          'Gagal mengupdate member discipleship journey: ${e.toString()}');
    }
  }

  Future<void> deleteMemberIcare({String? id}) async {
    try {
      final docRef = _firebaseFirestore.collection('icare_members').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.delete();
        debugPrint("✅ member icare dengan ID $id berhasil dihapus.");
      } else {
        throw Exception("member icare dengan ID $id tidak ditemukan.");
      }
    } on FirebaseException catch (e) {
      throw Exception('Gagal menghapus member icare: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menghapus member icare: ${e.toString()}');
    }
  }

  Future<void> deleteMemberDiscipleshipJourney({String? id}) async {
    try {
      final docRef =
          _firebaseFirestore.collection('discipleship_journey_members').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.delete();
        debugPrint(
            "✅ member discipleship journey dengan ID $id berhasil dihapus.");
      } else {
        throw Exception(
            "member discipleship journey dengan ID $id tidak ditemukan.");
      }
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal menghapus member discipleship journey: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception(
          'Gagal menghapus member discipleship journey: ${e.toString()}');
    }
  }
}
