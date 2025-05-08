part of 'list_trx_cubit.dart';

@freezed
class ListTrxState with _$ListTrxState {
   const factory ListTrxState.loading() = _Loading;
  const factory ListTrxState.success(TrxListSummaryResponse data) = _Success;
  const factory ListTrxState.failure() = _Failure;
}
