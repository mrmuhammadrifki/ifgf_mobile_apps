import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/register_firestore_service.dart';
import 'package:ifgf_apps/data/models/member_discipleship_journey_response.dart';
import 'package:ifgf_apps/data/models/member_icare_response.dart';

class RegisterRepository {
  final _registerFirestoreService =
      RegisterFirestoreService(FirebaseFirestore.instance);

  Future<DataState<List<MemberIcareResponse>>> getListMemberIcare() async {
    try {
      final response = await _registerFirestoreService.getListMemberIcare();

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<List<MemberDiscipleshipJourneyResponse>>>
      getListMemberDiscipleshipJourney() async {
    try {
      final response =
          await _registerFirestoreService.getListMemberDiscipleshipJourney();

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
