part of 'list_member_icare_cubit.dart';

@freezed
class ListMemberIcareState with _$ListMemberIcareState {
  const factory ListMemberIcareState.loading() = _Loading;
  const factory ListMemberIcareState.success(List<MemberIcareResponse> data) =
      _Success;
  const factory ListMemberIcareState.failure() = _Failure;
}
