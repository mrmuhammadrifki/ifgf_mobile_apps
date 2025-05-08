import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/acara_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_storage_service.dart';

class AcaraProvider extends ChangeNotifier {
  final FirebaseStorageService _firebaseStorageService;
  final AcaraFirestoreService _acaraFirestoreService;

  AcaraProvider(this._firebaseStorageService, this._acaraFirestoreService);

  Future<DataState<bool>> sharePoster({
    String? filePath,
    String? title,
    String? location,
    String? dateTime,
  }) async {
    try {
      await _firebaseStorageService.sharePoster(
        filePath: filePath,
        title: title,
        location: location,
        dateTime: dateTime,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal membagikan poster: ${e.toString()}');
    }
  }

  Future<DataState<bool>> deleteAcara({
    String? id,
  }) async {
    try {
      await _acaraFirestoreService.deleteAcara(id: id);

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal menghapus acara: ${e.toString()}');
    }
  }
}
