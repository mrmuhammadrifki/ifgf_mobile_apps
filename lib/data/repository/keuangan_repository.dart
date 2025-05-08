import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/keuangan_firestore_service.dart';
import 'package:ifgf_apps/data/models/trx_response.dart';

class KeuanganRepository {
  final _keuanganFirestoreService =
      KeuanganFirestoreService(FirebaseFirestore.instance);

  Future<DataState<TrxListSummaryResponse>> getListTrx(
      {String? date, String? category}) async {
    try {
      final response = await _keuanganFirestoreService.getListTrx(
          date: date, category: category);

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
