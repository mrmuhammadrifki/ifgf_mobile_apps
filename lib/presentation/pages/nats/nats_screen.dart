import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/create_acara_params.dart';
import 'package:ifgf_apps/data/models/nats_response.dart';
import 'package:ifgf_apps/presentation/pages/create_nats/provider/create_nats_provider.dart';
import 'package:ifgf_apps/presentation/pages/nats/cubit/list_nats_cubit.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/list_nats_shimmer.dart';
import 'package:ifgf_apps/presentation/widgets/nats_card.dart';

class NatsScreen extends StatefulWidget {
  const NatsScreen({super.key});

  @override
  State<NatsScreen> createState() => _NatsScreenState();
}

class _NatsScreenState extends State<NatsScreen> {
  static final _keyLoader = GlobalKey<State>();
  Future<void> _onRefresh() async {
    context.read<ListNatsCubit>().getAll();
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Nats",
        showBackIcon: true,
        suffixWidget: [
          TextButton(
            onPressed: _onGoToCreateNats,
            child: Text("Tambah").p18sm().blue(),
          )
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: _onRefresh,
        child: Container(
          width: Helper.widthScreen(context),
          height: Helper.heightScreen(context),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFCCDDF2),
              ],
            ),
          ),
          child: BlocBuilder<ListNatsCubit, ListNatsState>(
            builder: (context, state) {
              return state.when(
                loading: () => ListNatsShimmer(),
                success: (data) => _buildList(data),
                failure: () => const Center(child: Text('Tidak ada data')),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onGoToCreateNats({String? id, bool? isEdit}) async {
    final result = await context.push(
      RoutePath.createNats,
      extra: CreateAcaraParams(
        isEdit: isEdit ?? false,
        id: id ?? "",
      ),
    );

    if (result == true) {
      _onRefresh();
    }
  }

  Widget _buildList(List<NatsResponse> data) {
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = data[index];
        return NatsCard(
          onEdit: () => _onGoToCreateNats(
            id: item.id,
            isEdit: true,
          ),
          onDelete: () async {
            final result = await Modal.showConfirmationDialog(
              context,
              title: "Hapus Nats",
              message: "Apakah anda yakin ingin menghapus nats ini?",
            );

            if (result == true) {
              await _onDeleteNats(item.id);
              _onRefresh();
            }
          },
          date: item.tanggal ?? "",
          ayat: item.ayat ?? "",
          isi: item.isi ?? "",
        );
      },
    );
  }

  Future<void> _onDeleteNats(String? id) async {
    final provider = context.read<CreateNatsProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await provider.deleteNats(id: id);

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    if (!mounted) return;

    if (response is DataSuccess) {
      Modal.showSnackBar(
        context,
        text: "Berhasil menghapus nats",
        snackbarType: SnackbarType.success,
      );
    } else {
      final errorMessage =
          response.error?.toString() ?? "Terjadi kesalahan, silakan coba lagi.";
      Modal.showSnackBar(
        context,
        text: errorMessage,
        snackbarType: SnackbarType.danger,
      );
    }
  }
}
