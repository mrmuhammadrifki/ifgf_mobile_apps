import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/jadwal_firestore_service.dart';

class DetailJadwalProvider extends ChangeNotifier {
  final JadwalFirestoreService _jadwalFirestoreService;

  DetailJadwalProvider(this._jadwalFirestoreService);


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
}
