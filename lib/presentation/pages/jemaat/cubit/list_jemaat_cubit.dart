import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/detail_profile_response.dart';
import 'package:ifgf_apps/data/repository/user_repository.dart';

part 'list_jemaat_state.dart';
part 'list_jemaat_cubit.freezed.dart';

class ListJemaatCubit extends Cubit<ListJemaatState> {
  ListJemaatCubit() : super(ListJemaatState.loading());

   final _userRepository = UserRepository();

  var data = <DetailProfileResponse>[];

  void getAll() async {
    emit(const ListJemaatState.loading());

    await Future.delayed(Duration.zero);

    final response = await _userRepository.getListJemaat();

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData ?? [];

      if (data.isNotEmpty) {
        emit(ListJemaatState.success(data));
      } else {
        emit(const ListJemaatState.failure());
      }
    } else {
      emit(const ListJemaatState.failure());
    }
  }
}
