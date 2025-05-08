part of 'list_acara_cubit.dart';

@freezed
class ListAcaraState with _$ListAcaraState {
  const factory ListAcaraState.loading() = _Loading;
  const factory ListAcaraState.loadingMore(List<AcaraResponse> data) =
      _LoadingMore;
  const factory ListAcaraState.silentLoading(List<AcaraResponse> data) =
      _SilentLoading;
  const factory ListAcaraState.success(List<AcaraResponse> data) = _Success;
  const factory ListAcaraState.failure() = _Failure;

}
