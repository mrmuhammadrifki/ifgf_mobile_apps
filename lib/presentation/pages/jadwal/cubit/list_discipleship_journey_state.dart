part of 'list_discipleship_journey_cubit.dart';

@freezed
class ListDiscipleshipJourneyState with _$ListDiscipleshipJourneyState {
  const factory ListDiscipleshipJourneyState.loading() = _Loading;
  const factory ListDiscipleshipJourneyState.success(List<DiscipleshipJourneyResponse> data) =
      _Success;
  const factory ListDiscipleshipJourneyState.failure() = _Failure;
}
