import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/member_discipleship_journey_response.dart';
import 'package:ifgf_apps/data/repository/register_repository.dart';

part 'list_member_discipleship_journey_state.dart';
part 'list_member_discipleship_journey_cubit.freezed.dart';

class ListMemberDiscipleshipJourneyCubit
    extends Cubit<ListMemberDiscipleshipJourneyState> {
  ListMemberDiscipleshipJourneyCubit()
      : super(ListMemberDiscipleshipJourneyState.loading());

  final _registerRepository = RegisterRepository();

  var data = <MemberDiscipleshipJourneyResponse>[];

  void getAll() async {
    emit(const ListMemberDiscipleshipJourneyState.loading());

    await Future.delayed(Duration.zero);

    final response =
        await _registerRepository.getListMemberDiscipleshipJourney();

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData ?? [];

      if (data.isNotEmpty) {
        emit(ListMemberDiscipleshipJourneyState.success(data));
      } else {
        emit(const ListMemberDiscipleshipJourneyState.failure());
      }
    } else {
      emit(const ListMemberDiscipleshipJourneyState.failure());
    }
  }
}
