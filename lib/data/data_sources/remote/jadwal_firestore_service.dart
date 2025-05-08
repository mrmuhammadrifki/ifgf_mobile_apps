import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/data/models/discipleship_journey_response.dart';
import 'package:ifgf_apps/data/models/icare_response.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:ifgf_apps/data/models/super_sunday_response.dart';
import 'package:ifgf_apps/data/models/petugas.dart';
import 'package:uuid/uuid.dart';

class JadwalFirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  JadwalFirestoreService(
    FirebaseFirestore? firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore ??= FirebaseFirestore.instance;

  Future<void> createJadwalSuperSunday({
    String? dateTime,
    String? location,
    Petugas? petugas,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      final String jadwalId = const Uuid().v4();
      await _firebaseFirestore.collection('jadwal').doc(jadwalId).set({
        'id': jadwalId,
        'jenis_jadwal': "Super Sunday",
        'date_time': dateTime,
        'location': location,
        'petugas': petugas?.toJson(),
        'thumbnail': [
          thumbnail?.toJson(),
        ],
        'poster': [
          poster?.toJson(),
        ]
      });
    } on FirebaseException catch (e) {
      throw Exception('Gagal menyimpan data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menyimpan data jadwal: ${e.toString()}');
    }
  }

  Future<void> createJadwalIcare({
    String? dateTime,
    String? jenisIcare,
    String? location,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      final String jadwalId = const Uuid().v4();
      await _firebaseFirestore.collection('jadwal').doc(jadwalId).set({
        'id': jadwalId,
        'jenis_jadwal': "Icare",
        'jenis_icare': jenisIcare,
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
      throw Exception('Gagal menyimpan data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menyimpan data jadwal: ${e.toString()}');
    }
  }

  Future<void> createJadwalDiscipleshipJourney({
    String? dateTime,
    String? jenisDiscipleshipJourney,
    String? location,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      final String jadwalId = const Uuid().v4();
      await _firebaseFirestore.collection('jadwal').doc(jadwalId).set({
        'id': jadwalId,
        'jenis_jadwal': "Discipleship Journey",
        'jenis_discipleship_journey': jenisDiscipleshipJourney,
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
      throw Exception('Gagal menyimpan data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menyimpan data jadwal: ${e.toString()}');
    }
  }

  Future<List<SuperSundayResponse>> getListSuperSunday() async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('jadwal')
          .where('jenis_jadwal', isEqualTo: 'Super Sunday')
          .get();

      final superSundayResponse = querySnapshot.docs.map((doc) {
        return SuperSundayResponse.fromMap(doc.data());
      }).toList();

      superSundayResponse.sort(
        (a, b) => DateTime.parse(a.dateTime ?? "")
            .compareTo(DateTime.parse(b.dateTime ?? "")),
      );

      return superSundayResponse;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.toString()}');
    }
  }

  Future<List<IcareResponse>> getListIcare() async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('jadwal')
          .where('jenis_jadwal', isEqualTo: 'Icare')
          .get();

      final icareResponse = querySnapshot.docs.map((doc) {
        return IcareResponse.fromMap(doc.data());
      }).toList();

      icareResponse.sort(
        (a, b) => DateTime.parse(a.dateTime ?? "")
            .compareTo(DateTime.parse(b.dateTime ?? "")),
      );

      return icareResponse;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.toString()}');
    }
  }

  Future<List<DiscipleshipJourneyResponse>> getListDiscipleshipJourney() async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('jadwal')
          .where('jenis_jadwal', isEqualTo: 'Discipleship Journey')
          .get();

      final discipleshipJourneyResponse = querySnapshot.docs.map((doc) {
        debugPrint(querySnapshot.docs.toString());
        return DiscipleshipJourneyResponse.fromMap(doc.data());
      }).toList();

      discipleshipJourneyResponse.sort(
        (a, b) => DateTime.parse(a.dateTime ?? "")
            .compareTo(DateTime.parse(b.dateTime ?? "")),
      );

      return discipleshipJourneyResponse;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.toString()}');
    }
  }

  Future<SuperSundayResponse?> getOneJadwal({String? id}) async {
    try {
      final docSnapshot =
          await _firebaseFirestore.collection('jadwal').doc(id).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          debugPrint(data.toString());
          return SuperSundayResponse.fromMap(data);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.toString()}');
    }
  }

  Future<IcareResponse?> getOneIcare({String? id}) async {
    try {
      final docSnapshot =
          await _firebaseFirestore.collection('jadwal').doc(id).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          debugPrint(data.toString());
          return IcareResponse.fromMap(data);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.toString()}');
    }
  }

  Future<DiscipleshipJourneyResponse?> getOneDiscipleshipJourney(
      {String? id}) async {
    try {
      final docSnapshot =
          await _firebaseFirestore.collection('jadwal').doc(id).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          debugPrint(data.toString());
          return DiscipleshipJourneyResponse.fromMap(data);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data jadwal: ${e.toString()}');
    }
  }

  Future<void> updateJadwal({
    required String id,
    String? jenisIcare,
    String? jenisDiscipleshipJourney,
    String? dateTime,
    String? location,
    Petugas? petugas,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      final docRef = _firebaseFirestore.collection('jadwal').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final updateData = <String, dynamic>{};

        if (jenisIcare != null) updateData['jenis_icare'] = jenisIcare;
        if (jenisDiscipleshipJourney != null) {
          updateData['jenis_discipleship_journey'] = jenisDiscipleshipJourney;
        }
        if (dateTime != null) updateData['date_time'] = dateTime;
        if (location != null) updateData['location'] = location;
        if (petugas != null) updateData['petugas'] = petugas.toJson();
        if (thumbnail != null) updateData['thumbnail'] = [thumbnail.toJson()];
        if (poster != null) updateData['poster'] = [poster.toJson()];

        await docRef.update(updateData);
      } else {
        throw Exception('Data jadwal dengan id $id tidak ditemukan.');
      }
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengupdate data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengupdate data jadwal: ${e.toString()}');
    }
  }

  Future<void> deleteJadwal({String? id}) async {
    try {
      final docRef = _firebaseFirestore.collection('jadwal').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.delete();
        debugPrint("✅ Jadwal dengan ID $id berhasil dihapus.");
      } else {
        throw Exception("Jadwal dengan ID $id tidak ditemukan.");
      }
    } on FirebaseException catch (e) {
      throw Exception('Gagal menghapus data jadwal: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menghapus data jadwal: ${e.toString()}');
    }
  }
}
