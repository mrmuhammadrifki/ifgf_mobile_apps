part of 'detail_jadwal_cubit.dart';

@freezed
class DetailJadwalState with _$DetailJadwalState {
  const factory DetailJadwalState.loading() = _Loading;
  const factory DetailJadwalState.loadingMore(SuperSundayResponse? data) =
      _LoadingMore;
  const factory DetailJadwalState.silentLoading(SuperSundayResponse? data) =
      _SilentLoading;
  const factory DetailJadwalState.success(SuperSundayResponse? data) = _Success;
  const factory DetailJadwalState.failure() = _Failure;
}
