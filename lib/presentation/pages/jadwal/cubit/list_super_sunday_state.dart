part of 'list_super_sunday_cubit.dart';

@freezed
class ListSuperSundayState with _$ListSuperSundayState {
   const factory ListSuperSundayState.loading() = _Loading;
  const factory ListSuperSundayState.success(List<SuperSundayResponse> data) = _Success;
  const factory ListSuperSundayState.failure() = _Failure;
}
