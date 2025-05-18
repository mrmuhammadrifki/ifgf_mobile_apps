import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';

import 'package:ifgf_apps/data/data_sources/remote/nats_firestore_service.dart';
import 'package:ifgf_apps/data/models/nats_response.dart';

class CreateNatsProvider extends ChangeNotifier {
  final NatsFirestoreService _natsFirestoreService;

  CreateNatsProvider(this._natsFirestoreService);

  Future<DataState<bool>> createNats({
    String? date,
    String? ayat,
    String? isi,
  }) async {
    try {
      await _natsFirestoreService.createNats(
        date: date,
        ayat: ayat,
        isi: isi,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<bool>> updateNats({
    required String id,
    String? date,
    String? ayat,
    String? isi,
  }) async {
    try {
      await _natsFirestoreService.updateNats(
        id: id,
        date: date,
        ayat: ayat,
        isi: isi,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<NatsResponse?>> getOneNats({String? id}) async {
    try {
      final result = await _natsFirestoreService.getOneNats(id: id);

      debugPrint(result.toString());

      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

    Future<DataState<bool>> deleteNats({
    String? id,
  }) async {
    try {
      await _natsFirestoreService.deleteNats(id: id);

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal menghapus nats: ${e.toString()}');
    }
  }
}
