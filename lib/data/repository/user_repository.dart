import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/profile_firestore_service.dart';
import 'package:ifgf_apps/data/models/detail_profile_response.dart';

class UserRepository {
  final _profileFirestoreService =
      ProfileFirestoreService(FirebaseFirestore.instance);

  Future<DataState<List<DetailProfileResponse>>> getListJemaat() async {
    try {
      final response = await _profileFirestoreService.getListJemaat();

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
