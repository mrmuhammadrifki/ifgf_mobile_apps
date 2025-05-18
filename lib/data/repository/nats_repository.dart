import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/nats_firestore_service.dart';
import 'package:ifgf_apps/data/models/nats_response.dart';

class NatsRepository {
  final _natsFirestoreService =
      NatsFirestoreService(FirebaseFirestore.instance);

  Future<DataState<List<NatsResponse>>> getListNats() async {
    try {
      final response = await _natsFirestoreService.getListNats();

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
