import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/data/models/nats_response.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NatsFirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  NatsFirestoreService(
    FirebaseFirestore? firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore ??= FirebaseFirestore.instance;

  Future<void> createNats({
    String? date, // format: 'yyyy-MM-dd'
    String? ayat,
    String? isi,
  }) async {
    try {
      // Konversi string ke DateTime (pastikan format benar)
      final inputDate = DateTime.parse(date ?? ""); // misal: '2025-05-21'
      final normalizedDate = DateTime(
          inputDate.year, inputDate.month, inputDate.day); // jam 00:00:00

      // Cek apakah tanggal sudah ada
      final existing = await _firebaseFirestore
          .collection('nats')
          .where('tanggal', isGreaterThanOrEqualTo: normalizedDate)
          .where('tanggal', isLessThan: normalizedDate.add(Duration(days: 1)))
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        throw Exception('Nats untuk tanggal tersebut sudah ada.');
      }

      // Simpan ke Firestore
      final String natsId = const Uuid().v4();
      await _firebaseFirestore.collection('nats').doc(natsId).set({
        'id': natsId,
        'ayat': ayat,
        'isi': isi,
        'tanggal': normalizedDate.toIso8601String(),
        'created_at': inputDate.toIso8601String(),
      });
    } on FirebaseException catch (e) {
      throw Exception('Gagal menyimpan data nats: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menyimpan data nats: ${e.toString()}');
    }
  }

  Future<NatsResponse?> getTodayNats() async {
    try {
      // Konversi string ke DateTime (pastikan format benar)
      final inputDate = DateTime.now(); // misal: '2025-05-21'
      final normalizedDate = DateTime(
          inputDate.year, inputDate.month, inputDate.day); // jam 00:00:00

      debugPrint("normalizedDate: ${normalizedDate.toIso8601String()}");

      final snapshot = await _firebaseFirestore
          .collection('nats')
          .where('tanggal', isEqualTo: normalizedDate.toIso8601String())
          .limit(1)
          .get();

      debugPrint("snapshot: ${snapshot.docs.length}");
      debugPrint("snapshot: ${snapshot.docs.first.data()}");

      if (snapshot.docs.isNotEmpty) {
        return NatsResponse.fromMap(snapshot.docs.first.data());
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Gagal mengambil nats hari ini: ${e.toString()}');
    }
  }

  Future<List<NatsResponse>> getListNats() async {
    try {
      final querySnapshot = await _firebaseFirestore.collection('nats').get();

      final listAcara = querySnapshot.docs.map((doc) {
        return NatsResponse.fromMap(doc.data());
      }).toList();

      listAcara.sort(
        (a, b) => DateTime.parse(b.createdAt ?? "").compareTo(
          DateTime.parse(a.createdAt ?? ""),
        ),
      );

      return listAcara;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data acara: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data acara: ${e.toString()}');
    }
  }

  Future<NatsResponse?> getOneNats({String? id}) async {
    try {
      final docSnapshot =
          await _firebaseFirestore.collection('nats').doc(id).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          return NatsResponse.fromMap(data);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data nats: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data nats: ${e.toString()}');
    }
  }

  Future<void> updateNats({
    required String id,
    String? date,
    String? ayat,
    String? isi,
  }) async {
    try {
      final docRef = _firebaseFirestore.collection('nats').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final updateData = <String, dynamic>{};

        if (date != null) updateData['tanggal'] = date;
        if (ayat != null) updateData['ayat'] = ayat;
        if (isi != null) updateData['isi'] = isi;

        await docRef.update(updateData);
      } else {
        throw Exception('Data nats dengan id $id tidak ditemukan.');
      }
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengupdate data nats: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengupdate data nats: ${e.toString()}');
    }
  }

  Future<void> deleteNats({String? id}) async {
    try {
      final docRef = _firebaseFirestore.collection('nats').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.delete();
      } else {
        throw Exception("nats dengan ID $id tidak ditemukan.");
      }
    } on FirebaseException catch (e) {
      throw Exception('Gagal menghapus data nats: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menghapus data nats: ${e.toString()}');
    }
  }
}
