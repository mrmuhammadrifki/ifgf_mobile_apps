import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/data_sources/remote/register_firestore_service.dart';
import 'package:ifgf_apps/data/models/member_icare_response.dart';

class RegisterIcareProvider extends ChangeNotifier {
  final RegisterFirestoreService _registerFirestoreService;

  RegisterIcareProvider(this._registerFirestoreService);

  Future<DataState<bool>> registerIcare({
    String? fullName,
    String? jenisIcare,
    String? birthDate,
    String? age,
    String? phone,
  }) async {
    try {
      await _registerFirestoreService.registerIcare(
        fullName: fullName,
        jenisIcare: jenisIcare,
        birthDate: birthDate,
        age: age,
        phone: phone,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal mendaftar icare: ${e.toString()}');
    }
  }

  Future<DataState<MemberIcareResponse?>> getOneMemberIcare({String? id}) async {
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

  Future<DataState<bool>> deleteMemberIcare({
    String? id,
  }) async {
    try {
      await _registerFirestoreService.deleteMemberIcare(
        id: id,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal menghapus member icare: ${e.toString()}');
    }
  }
}
