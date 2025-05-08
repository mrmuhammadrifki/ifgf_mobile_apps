import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/acara_firestore_service.dart';
import 'package:ifgf_apps/data/models/acara_response.dart';

class AcaraRepository {
  final _acaraFirestoreService =
      AcaraFirestoreService(FirebaseFirestore.instance);

  Future<DataState<List<AcaraResponse>>> getAcaraList() async {
    try {
      final response = await _acaraFirestoreService.getListAcara();

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
