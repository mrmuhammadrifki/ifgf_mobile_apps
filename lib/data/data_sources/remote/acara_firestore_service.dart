import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/data/models/acara_response.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:uuid/uuid.dart';

class AcaraFirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  AcaraFirestoreService(
    FirebaseFirestore? firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore ??= FirebaseFirestore.instance;

  Future<void> createAcara({
    String? title,
    String? dateTime,
    String? location,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      final String acaraId = const Uuid().v4();
      await _firebaseFirestore.collection('acara').doc(acaraId).set({
        'id': acaraId,
        'title': title,
        'date_time': dateTime,
        'location': location,
        'thumbnail': [
          thumbnail?.toJson(),
        ],
        'poster': [
          poster?.toJson(),
        ]
      });
    } on FirebaseException catch (e) {
      throw Exception('Gagal menyimpan data user: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menyimpan data user: ${e.toString()}');
    }
  }

  Future<List<AcaraResponse>> getListAcara() async {
    try {
      final querySnapshot = await _firebaseFirestore.collection('acara').get();

      final listAcara = querySnapshot.docs.map((doc) {
        return AcaraResponse.fromMap(doc.data());
      }).toList();

      listAcara.sort(
        (a, b) => DateTime.parse(a.dateTime ?? "").compareTo(
          DateTime.parse(b.dateTime ?? ""),
        ),
      );

      return listAcara;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data acara: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data acara: ${e.toString()}');
    }
  }

  Future<AcaraResponse?> getOneAcara({String? id}) async {
    try {
      final docSnapshot =
          await _firebaseFirestore.collection('acara').doc(id).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          debugPrint(data.toString());
          return AcaraResponse.fromMap(data);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data acara: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data acara: ${e.toString()}');
    }
  }

  Future<void> updateAcara({
    required String id,
    String? title,
    String? dateTime,
    String? location,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      final docRef = _firebaseFirestore.collection('acara').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final updateData = <String, dynamic>{};

        if (title != null) updateData['title'] = title;
        if (dateTime != null) updateData['date_time'] = dateTime;
        if (location != null) updateData['location'] = location;
        if (thumbnail != null) updateData['thumbnail'] = [thumbnail.toJson()];
        if (poster != null) updateData['poster'] = [poster.toJson()];

        await docRef.update(updateData);
      } else {
        throw Exception('Data acara dengan id $id tidak ditemukan.');
      }
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengupdate data acara: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengupdate data acara: ${e.toString()}');
    }
  }

  Future<void> deleteAcara({String? id}) async {
  try {
    final docRef = _firebaseFirestore.collection('acara').doc(id);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      await docRef.delete();
      debugPrint("✅ Acara dengan ID $id berhasil dihapus.");
    } else {
      throw Exception("Acara dengan ID $id tidak ditemukan.");
    }
  } on FirebaseException catch (e) {
    throw Exception('Gagal menghapus data acara: ${e.code} - ${e.message}');
  } catch (e) {
    throw Exception('Gagal menghapus data acara: ${e.toString()}');
  }
}

}
