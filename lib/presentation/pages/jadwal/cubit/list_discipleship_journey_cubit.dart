import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/discipleship_journey_response.dart';
import 'package:ifgf_apps/data/repository/jadwal_repository.dart';

part 'list_discipleship_journey_state.dart';
part 'list_discipleship_journey_cubit.freezed.dart';

class ListDiscipleshipJourneyCubit extends Cubit<ListDiscipleshipJourneyState> {
  ListDiscipleshipJourneyCubit() : super(ListDiscipleshipJourneyState.loading());

  final _jadwalRepository = JadwalRepository();

  var data = <DiscipleshipJourneyResponse>[];

  void getAll() async {
    emit(const ListDiscipleshipJourneyState.loading());

    await Future.delayed(Duration.zero);

    final response = await _jadwalRepository.getDiscipleshipJourneyList();

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData ?? [];

      if (data.isNotEmpty) {
        emit(ListDiscipleshipJourneyState.success(data));
      } else {
        emit(const ListDiscipleshipJourneyState.failure());
      }
    } else {
      emit(const ListDiscipleshipJourneyState.failure());
    }
  }
}
