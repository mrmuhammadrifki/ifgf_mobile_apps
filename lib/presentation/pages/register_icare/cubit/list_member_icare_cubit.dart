import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/member_icare_response.dart';
import 'package:ifgf_apps/data/repository/register_repository.dart';

part 'list_member_icare_state.dart';
part 'list_member_icare_cubit.freezed.dart';

class ListMemberIcareCubit extends Cubit<ListMemberIcareState> {
  ListMemberIcareCubit() : super(ListMemberIcareState.loading());
  final _registerRepository = RegisterRepository();

  var data = <MemberIcareResponse>[];

  void getAll() async {
    emit(const ListMemberIcareState.loading());

    await Future.delayed(Duration.zero);

    final response = await _registerRepository.getListMemberIcare();

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData ?? [];

      if (data.isNotEmpty) {
        emit(ListMemberIcareState.success(data));
      } else {
        emit(const ListMemberIcareState.failure());
      }
    } else {
      emit(const ListMemberIcareState.failure());
    }
  }
}
