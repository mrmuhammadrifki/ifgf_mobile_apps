import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/trx_response.dart';
import 'package:ifgf_apps/data/repository/keuangan_repository.dart';

part 'list_trx_state.dart';
part 'list_trx_cubit.freezed.dart';

class ListTrxCubit extends Cubit<ListTrxState> {
  ListTrxCubit() : super(ListTrxState.loading());

  final _keuanganRepository = KeuanganRepository();

  TrxListSummaryResponse? data;

  void getAll({String? date, String? category}) async {
    emit(const ListTrxState.loading());

    await Future.delayed(Duration.zero);

    final response = await _keuanganRepository.getListTrx(date: date, category: category);

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData;

      if (data != null) {
        emit(ListTrxState.success(data!));
      } else {
        emit(const ListTrxState.failure());
      }
    } else {
      emit(const ListTrxState.failure());
    }
  }
}
