import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/super_sunday_response.dart';
import 'package:ifgf_apps/data/repository/jadwal_repository.dart';

part 'detail_jadwal_state.dart';
part 'detail_jadwal_cubit.freezed.dart';

class DetailJadwalCubit extends Cubit<DetailJadwalState> {
  DetailJadwalCubit() : super(DetailJadwalState.loading());

   final _jadwalRepository = JadwalRepository();

  SuperSundayResponse? data;

  void getAll({String? id}) async {
    emit(const DetailJadwalState.loading());

    await Future.delayed(Duration.zero);

    final response = await _jadwalRepository.getOneJadwal(id: id);

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData;

      if (data?.id?.isNotEmpty == true) {
        emit(DetailJadwalState.success(data));
      } else {
        emit(const DetailJadwalState.failure());
      }
    } else {
      emit(const DetailJadwalState.failure());
    }
  }
}
