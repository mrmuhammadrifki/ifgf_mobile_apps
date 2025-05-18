part of 'list_nats_cubit.dart';

@freezed
class ListNatsState with _$ListNatsState {
    const factory ListNatsState.loading() = _Loading;
  const factory ListNatsState.success(List<NatsResponse> data) = _Success;
  const factory ListNatsState.failure() = _Failure;
}
