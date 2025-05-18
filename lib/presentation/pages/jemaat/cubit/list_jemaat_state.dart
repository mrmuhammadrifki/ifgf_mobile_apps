part of 'list_jemaat_cubit.dart';

@freezed
class ListJemaatState with _$ListJemaatState {
  const factory ListJemaatState.loading() = _Loading;
  const factory ListJemaatState.success(List<DetailProfileResponse> data) =
      _Success;
  const factory ListJemaatState.failure() = _Failure;
}
