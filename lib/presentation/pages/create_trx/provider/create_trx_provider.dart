import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/keuangan_firestore_service.dart';
import 'package:ifgf_apps/data/models/trx_response.dart';

class CreateTrxProvider extends ChangeNotifier {
  final KeuanganFirestoreService _keuanganFirestoreService;

  CreateTrxProvider(this._keuanganFirestoreService);

  Future<DataState<bool>> createTrx({
    String? jenisTrx,
    String? category,
    String? createdAt,
    String? nominal,
    String? note,
  }) async {
    try {
      await _keuanganFirestoreService.createTrx(
        jenisTrx: jenisTrx,
        category: category,
        createdAt: createdAt,
        nominal: nominal,
        note: note,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal menyimpan data transaksi: ${e.toString()}');
    }
  }

  Future<DataState<bool>> updateTrx({
    required String id,
    String? jenisTrx,
    String? category,
    String? createdAt,
    String? nominal,
    String? note,
  }) async {
    try {
      await _keuanganFirestoreService.updateTrx(
        id: id,
        jenisTrx: jenisTrx,
        category: category,
        createdAt: createdAt,
        nominal: nominal,
        note: note,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal update data transaksi: ${e.toString()}');
    }
  }

  Future<DataState<TrxResponse?>> getOneTrx({String? id}) async {
    try {
      final result = await _keuanganFirestoreService.getOneTrx(id: id);

      debugPrint(result.toString());

      return DataSuccess(result);
    } catch (e) {
      return DataFailed('Gagal mendapatkan data transaksi: ${e.toString()}');
    }
  }
}
