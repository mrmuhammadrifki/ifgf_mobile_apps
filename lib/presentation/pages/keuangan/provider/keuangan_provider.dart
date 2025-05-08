import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/keuangan_firestore_service.dart';

class KeuanganProvider extends ChangeNotifier {
    final KeuanganFirestoreService _keuanganFirestoreService;

    KeuanganProvider(this._keuanganFirestoreService);

    Future<DataState<bool?>> deleteTrx({String? id}) async {
    try {
      await _keuanganFirestoreService.deleteTrx(id: id);

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal menghapus data transaksi: ${e.toString()}');
    }
  }
}