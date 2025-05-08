import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/icare_response.dart';
import 'package:ifgf_apps/data/repository/jadwal_repository.dart';

part 'list_icare_state.dart';
part 'list_icare_cubit.freezed.dart';

class ListIcareCubit extends Cubit<ListIcareState> {
  ListIcareCubit() : super(ListIcareState.loading());

  final _jadwalRepository = JadwalRepository();

  var data = <IcareResponse>[];

  void getAll() async {
    emit(const ListIcareState.loading());

    await Future.delayed(Duration.zero);

    final response = await _jadwalRepository.getIcareList();

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData ?? [];

      if (data.isNotEmpty) {
        emit(ListIcareState.success(data));
      } else {
        emit(const ListIcareState.failure());
      }
    } else {
      emit(const ListIcareState.failure());
    }
  }
}
