import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/acara_response.dart';
import 'package:ifgf_apps/data/models/create_acara_params.dart';
import 'package:ifgf_apps/presentation/pages/acara/cubit/cubit/list_acara_cubit.dart';
import 'package:ifgf_apps/presentation/pages/acara/provider/acara_provider.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/event_card.dart';
import 'package:ifgf_apps/presentation/widgets/list_event_shimmer.dart';

class AcaraScreen extends StatefulWidget {
  const AcaraScreen({super.key});

  @override
  State<AcaraScreen> createState() => _AcaraScreenState();
}

class _AcaraScreenState extends State<AcaraScreen> {
  static final _keyLoader = GlobalKey<State>();
  Future<void> _onRefresh() async {
    context.read<ListAcaraCubit>().getAll();
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: provider.profile?.isAdmin ?? false
          ? CustomAppBar(
              titleText: "Acara",
              showBackIcon: true,
              suffixWidget: [
                TextButton(
                  onPressed: () => _onGoToCreateAcara(),
                  child: Text("Tambah").p18sm().blue(),
                )
              ],
            )
          : CustomAppBar(
              titleText: "Acara",
              showBackIcon: true,
            ),
      body: SafeArea(
        child: Container(
          width: Helper.widthScreen(context),
          height: Helper.heightScreen(context),
          padding: const EdgeInsets.all(16.0),
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
          child: RefreshIndicator.adaptive(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Acara Terdekat Minggu Ini").p18m().black2(),
                  SizedBox(height: 16),
                  BlocBuilder<ListAcaraCubit, ListAcaraState>(
                    builder: (context, state) {
                      return state.when(
                        loading: () => ListEventShimmer(),
                        silentLoading: (data) => _buildList(data),
                        loadingMore: (data) => _buildList(data),
                        success: (data) => _buildList(data),
                        failure: () =>
                            const Center(child: Text('Tidak ada data')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<AcaraResponse> data) {
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return EventCard(
          item: data[index],
          actionButtons: _buildActionButton(data[index]),
        );
      },
    );
  }

  void _onGoToCreateAcara({bool? isEdit, String? id}) async {
    final result = await context.push(
      RoutePath.createAcara,
      extra: CreateAcaraParams(id: id ?? "", isEdit: isEdit ?? false),
    );

    if (result == true) {
      await Future.delayed(Duration.zero);
      _onRefresh();
    }
  }

  List<Widget> _buildActionButton(AcaraResponse? acara) {
    final provider = context.watch<ProfileProvider>();
    return [
      provider.profile?.isAdmin ?? false
          ? Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: BaseColor.red,
                ),
                onPressed: () async {
                  final result = await Modal.showConfirmationDialog(
                    context,
                    title: "Hapus Acara",
                    message: "Apakah anda yakin ingin menghapus acara ini?",
                  );

                  if (result == true) {
                    await _onDeleteAcara(acara?.id);
                    _onRefresh();
                  }
                },
                child: Text("Hapus"),
              ),
            )
          : SizedBox(),
      SizedBox(width: provider.profile?.isAdmin ?? false ? 4 : 0),
      provider.profile?.isAdmin ?? false
          ? Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: BaseColor.yellow,
                ),
                onPressed: () =>
                    _onGoToCreateAcara(isEdit: true, id: acara?.id),
                child: Text("Edit"),
              ),
            )
          : SizedBox(),
      SizedBox(width: provider.profile?.isAdmin ?? false ? 4 : 0),
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: BaseColor.blue,
          ),
          onPressed: acara?.poster?.first?.url.isEmpty == true
              ? null
              : () => _onSharePoster(acara),
          child: Text("Bagikan"),
        ),
      ),
    ];
  }

  void _onSharePoster(AcaraResponse? acara) async {
    final acaraProvider = context.read<AcaraProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await acaraProvider.sharePoster(
      filePath: acara?.poster?.first?.filePath,
      title: acara?.title,
      location: acara?.location,
      dateTime: acara?.dateTime?.formattedDayDateTime(),
    );

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    if (!mounted) return;

    if (response is DataSuccess) {
      Modal.showSnackBar(
        context,
        text: "Berhasil share poster",
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

  Future<void> _onDeleteAcara(String? id) async {
    final acaraProvider = context.read<AcaraProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await acaraProvider.deleteAcara(id: id);

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    if (!mounted) return;

    if (response is DataSuccess) {
      Modal.showSnackBar(
        context,
        text: "Berhasil menghapus acara",
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
