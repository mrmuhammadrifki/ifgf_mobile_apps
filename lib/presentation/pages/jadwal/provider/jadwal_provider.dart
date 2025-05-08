import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_storage_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/jadwal_firestore_service.dart';
import 'package:ifgf_apps/data/models/petugas.dart';

class JadwalProvider extends ChangeNotifier {
  final FirebaseStorageService _firebaseStorageService;
  final JadwalFirestoreService _jadwalFirestoreService;

  JadwalProvider(
    this._firebaseStorageService,
    this._jadwalFirestoreService,
  );

  Future<DataState<bool>> deleteJadwal({
    String? id,
  }) async {
    try {
      await _jadwalFirestoreService.deleteJadwal(id: id);

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal menghapus jadwal: ${e.toString()}');
    }
  }

  Future<DataState<bool>> sharePoster({
    String? filePath,
    String? title,
    String? location,
    String? dateTime,
    Petugas? petugas,
  }) async {
    try {
      await _firebaseStorageService.sharePoster(
        filePath: filePath,
        title: title,
        location: location,
        dateTime: dateTime,
        petugas: petugas,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal membagikan poster: ${e.toString()}');
    }
  }
}
