import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/register_firestore_service.dart';
import 'package:ifgf_apps/data/models/member_discipleship_journey_response.dart';
import 'package:ifgf_apps/data/models/member_icare_response.dart';

class RegisterDiscipleshipJourneyProvider extends ChangeNotifier {
  final RegisterFirestoreService _registerFirestoreService;

  RegisterDiscipleshipJourneyProvider(this._registerFirestoreService);

  Future<DataState<bool>> registerDiscipleshipJourney({
    String? fullName,
    String? jenisDiscipleshipJourney,
    String? birthDate,
    String? age,
    String? phone,
  }) async {
    try {
      await _registerFirestoreService.registerDiscipleshipJourney(
        fullName: fullName,
        jenisDiscipleshipJourney: jenisDiscipleshipJourney,
        birthDate: birthDate,
        age: age,
        phone: phone,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<MemberIcareResponse?>> getOneMemberIcare(
      {String? id}) async {
    try {
      final response = await _registerFirestoreService.getOneMemberIcare(
        id: id,
      );

      return DataSuccess(response);
    } catch (e) {
      return DataFailed('Gagal mendapatkan member icare: ${e.toString()}');
    }
  }

  Future<DataState<bool>> updateMemberIcare({
    String? id,
    String? fullName,
    String? jenisIcare,
    String? birthDate,
    String? age,
    String? phone,
  }) async {
    try {
      await _registerFirestoreService.updateMemberIcare(
        id: id ?? "",
        fullName: fullName,
        jenisIcare: jenisIcare,
        birthDate: birthDate,
        age: age,
        phone: phone,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal mengubah member icare: ${e.toString()}');
    }
  }

  Future<DataState<MemberDiscipleshipJourneyResponse?>> getOneMemberDiscipleshipJourney(
      {String? id}) async {
    try {
      final response = await _registerFirestoreService.getOneMemberDiscipleshipJourney(
        id: id,
      );

      return DataSuccess(response);
    } catch (e) {
      return DataFailed('Gagal mendapatkan member discipleship journey: ${e.toString()}');
    }
  }

  Future<DataState<bool>> updateMemberDiscipleshipJourney({
    String? id,
    String? fullName,
    String? jenisDiscipleshipJourney,
    String? birthDate,
    String? age,
    String? phone,
  }) async {
    try {
      await _registerFirestoreService.updateMemberDiscipleshipJourney(
        id: id ?? "",
        fullName: fullName,
        jenisDiscipleshipJourney: jenisDiscipleshipJourney,
        birthDate: birthDate,
        age: age,
        phone: phone,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal mengubah member discipleship journey: ${e.toString()}');
    }
  }

  Future<DataState<bool>> deleteMemberDiscipleshipJourney({
    String? id,
  }) async {
    try {
      await _registerFirestoreService.deleteMemberDiscipleshipJourney(
        id: id,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed(
          'Gagal menghapus member discipleship journey: ${e.toString()}');
    }
  }
}
