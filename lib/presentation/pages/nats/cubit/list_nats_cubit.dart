import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/data/models/nats_response.dart';
import 'package:ifgf_apps/data/repository/nats_repository.dart';

part 'list_nats_state.dart';
part 'list_nats_cubit.freezed.dart';

class ListNatsCubit extends Cubit<ListNatsState> {
  ListNatsCubit() : super(ListNatsState.loading());

  final _natsRepository = NatsRepository();

  var data = <NatsResponse>[];

  void getAll() async {
    emit(const ListNatsState.loading());

    await Future.delayed(Duration.zero);

    final response = await _natsRepository.getListNats();

    if (response is DataSuccess) {
      final responseData = response.data;
      data = responseData ?? [];

      if (data.isNotEmpty) {
        emit(ListNatsState.success(data));
      } else {
        emit(const ListNatsState.failure());
      }
    } else {
      emit(const ListNatsState.failure());
    }
  }
}
