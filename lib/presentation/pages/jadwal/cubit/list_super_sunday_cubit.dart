import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/super_sunday_response.dart';
import 'package:ifgf_apps/data/repository/jadwal_repository.dart';


part 'list_super_sunday_state.dart';
part 'list_super_sunday_cubit.freezed.dart';

class ListSuperSundayCubit extends Cubit<ListSuperSundayState> {
  ListSuperSundayCubit() : super(ListSuperSundayState.loading());

  final _jadwalRepository = JadwalRepository();

  var data = <SuperSundayResponse>[];

  void getAll() async {
    emit(const ListSuperSundayState.loading());

    await Future.delayed(Duration.zero);

    final response = await _jadwalRepository.getSuperSundayList();

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData ?? [];

      if (data.isNotEmpty) {
        emit(ListSuperSundayState.success(data));
      } else {
        emit(const ListSuperSundayState.failure());
      }
    } else {
      emit(const ListSuperSundayState.failure());
    }
  }
  
}
