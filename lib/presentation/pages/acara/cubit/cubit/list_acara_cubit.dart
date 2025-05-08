import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/acara_response.dart';
import 'package:ifgf_apps/data/repository/acara_repository.dart';

part 'list_acara_state.dart';
part 'list_acara_cubit.freezed.dart';

class ListAcaraCubit extends Cubit<ListAcaraState> {
  ListAcaraCubit() : super(const ListAcaraState.loading());

  final _acaraRepository = AcaraRepository();

  var data = <AcaraResponse>[];

  void getAll() async {
    emit(const ListAcaraState.loading());

    await Future.delayed(Duration.zero);

    final response = await _acaraRepository.getAcaraList();

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData ?? [];

      if (data.isNotEmpty) {
        emit(ListAcaraState.success(data));
      } else {
        emit(const ListAcaraState.failure());
      }
    } else {
      emit(const ListAcaraState.failure());
    }
  }
}
