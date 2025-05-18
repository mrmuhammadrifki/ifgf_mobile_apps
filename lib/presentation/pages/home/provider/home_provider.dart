import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/nats_firestore_service.dart';
import 'package:ifgf_apps/data/models/nats_response.dart';

class HomeProvider extends ChangeNotifier {
  final NatsFirestoreService _natsFirestoreService;
  HomeProvider(this._natsFirestoreService);

  NatsResponse? _natsResponse;
  NatsResponse? get natsResponse => _natsResponse;

  Future<DataState<bool>> getTodayNats() async {
    try {
      final result = await _natsFirestoreService.getTodayNats();
      if (result == null) {
        _natsResponse = null;
      }
      _natsResponse = result;
      notifyListeners();

      return DataSuccess(true);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
