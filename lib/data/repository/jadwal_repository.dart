import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/jadwal_firestore_service.dart';
import 'package:ifgf_apps/data/models/discipleship_journey_response.dart';
import 'package:ifgf_apps/data/models/icare_response.dart';
import 'package:ifgf_apps/data/models/super_sunday_response.dart';

class JadwalRepository {
  final _jadwalFirestoreService =
      JadwalFirestoreService(FirebaseFirestore.instance);

  Future<DataState<List<DiscipleshipJourneyResponse>>>
      getDiscipleshipJourneyList() async {
    try {
      final response =
          await _jadwalFirestoreService.getListDiscipleshipJourney();

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<List<SuperSundayResponse>>> getSuperSundayList() async {
    try {
      final response = await _jadwalFirestoreService.getListSuperSunday();

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<List<IcareResponse>>> getIcareList() async {
    try {
      final response = await _jadwalFirestoreService.getListIcare();

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<SuperSundayResponse?>> getOneJadwal({String? id}) async {
    try {
      final result = await _jadwalFirestoreService.getOneJadwal(id: id);
      debugPrint(result.toString());

      return DataSuccess(result);
    } catch (e) {
      return DataFailed('Gagal mendapatkan data jadwal: ${e.toString()}');
    }
  }
}
