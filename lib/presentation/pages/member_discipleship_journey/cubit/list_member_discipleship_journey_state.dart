part of 'list_member_discipleship_journey_cubit.dart';

@freezed
class ListMemberDiscipleshipJourneyState with _$ListMemberDiscipleshipJourneyState {
  const factory ListMemberDiscipleshipJourneyState.loading() = _Loading;
  const factory ListMemberDiscipleshipJourneyState.success(List<MemberDiscipleshipJourneyResponse> data) = _Success;
  const factory ListMemberDiscipleshipJourneyState.failure() = _Failure;
}
