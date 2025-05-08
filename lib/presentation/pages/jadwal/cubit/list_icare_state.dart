part of 'list_icare_cubit.dart';

@freezed
class ListIcareState with _$ListIcareState {
  const factory ListIcareState.loading() = _Loading;
  const factory ListIcareState.success(List<IcareResponse> data) = _Success;
  const factory ListIcareState.failure() = _Failure;
}
