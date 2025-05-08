import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/create_acara_params.dart';
import 'package:ifgf_apps/data/models/super_sunday_response.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/cubit/list_discipleship_journey_cubit.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/cubit/list_icare_cubit.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/cubit/list_super_sunday_cubit.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/provider/jadwal_provider.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/tabs/discipleship_journey_tab.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/tabs/icare_tab.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/tabs/super_sunday_tab.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/list_event_shimmer.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;
  static final _keyLoader = GlobalKey<State>();

  Future<void> _onRefresh() async {
    context.read<ListSuperSundayCubit>().getAll();
    context.read<ListIcareCubit>().getAll();
    context.read<ListDiscipleshipJourneyCubit>().getAll();
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);

    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: provider.profile?.isAdmin ?? false
          ? CustomAppBar(
              titleText: "Jadwal",
              showBackIcon: true,
              suffixWidget: [
                TextButton(
                  onPressed: () => _buildPilihJenisJadwalDialog(),
                  child: Text("Tambah").p18sm().blue(),
                )
              ],
            )
          : CustomAppBar(
              titleText: "Jadwal",
              showBackIcon: true,
            ),
      body: SafeArea(
        child: Column(
          children: [
            _buildTab(),
            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  RefreshIndicator.adaptive(
                    onRefresh: _onRefresh,
                    child:
                        BlocBuilder<ListSuperSundayCubit, ListSuperSundayState>(
                      builder: (context, state) {
                        return state.when(
                          loading: () => Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListEventShimmer(),
                          ),
                          success: (data) => SuperSundayTab(
                            onDetail: (id) => _onGoToDetailJadwal(id),
                            data: data,
                            onSharePoster: (item) => _onSharePoster(item),
                          ),
                          failure: () => const Center(
                            child: Text('Tidak ada data'),
                          ),
                        );
                      },
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: BlocBuilder<ListIcareCubit, ListIcareState>(
                      builder: (context, state) {
                        return state.when(
                          loading: () => Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListEventShimmer(),
                          ),
                          success: (data) => IcareTab(
                            onEdit: (id) =>
                                _onGoToCreateIcare(id: id, isEdit: true),
                            onDelete: (id) => _onDeleteJadwal(id: id),
                            onSharePoster: (item) => _onSharePoster(
                              SuperSundayResponse(
                                id: item?.id,
                                jenisJadwal: item?.jenisIcare,
                                dateTime: item?.dateTime,
                                location: item?.location,
                                thumbnail: item?.thumbnail,
                                poster: item?.poster,
                              ),
                            ),
                            data: data,
                          ),
                          failure: () => const Center(
                            child: Text('Tidak ada data'),
                          ),
                        );
                      },
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: BlocBuilder<ListDiscipleshipJourneyCubit,
                        ListDiscipleshipJourneyState>(
                      builder: (context, state) {
                        return state.when(
                          loading: () => Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListEventShimmer(),
                          ),
                          success: (data) => DiscipleshipJourneyTab(
                            onEdit: (id) => _onGoToCreateDiscipleshipJourney(
                                id: id, isEdit: true),
                            onDelete: (id) => _onDeleteJadwal(id: id),
                            onSharePoster: (item) => _onSharePoster(
                              SuperSundayResponse(
                                id: item?.id,
                                jenisJadwal: item?.jenisDiscipleshipJourney,
                                dateTime: item?.dateTime,
                                location: item?.location,
                                thumbnail: item?.thumbnail,
                                poster: item?.poster,
                              ),
                            ),
                            data: data,
                          ),
                          failure: () => const Center(
                            child: Text('Tidak ada data'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDeleteJadwal({String? id}) async {
    final jadwalProvider = context.read<JadwalProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await jadwalProvider.deleteJadwal(id: id);

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    if (!mounted) return;

    if (response is DataSuccess) {
      _onRefresh();
      Modal.showSnackBar(
        context,
        text: "Berhasil menghapus jadwal",
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

  void _onGoToCreateDiscipleshipJourney({String? id, bool? isEdit}) async {
    final result = await context.push(
      RoutePath.createJadwalDiscipleshipJourney,
      extra: CreateAcaraParams(isEdit: isEdit ?? false, id: id ?? ""),
    );

    if (result == true) {
      await Future.delayed(Duration.zero);
      _onRefresh();
    }
  }

  void _onSharePoster(SuperSundayResponse? item) async {
    final jadwalProvider = context.read<JadwalProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await jadwalProvider.sharePoster(
        filePath: item?.poster?.first?.filePath,
        title: item?.jenisJadwal,
        location: item?.location,
        dateTime: item?.dateTime?.formattedDayDateTime(),
        petugas: item?.petugas);

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

  void _onGoToDetailJadwal(String? id) async {
    final result = await context.push(RoutePath.detailJadwal, extra: id);

    if (result == true) {
      _onRefresh();
    }
  }

  Widget _buildTab() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: TabBar(
        controller: tabController,
        dividerHeight: 0,
        isScrollable: true,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorWeight: 0,
        unselectedLabelColor: BaseColor.grey,
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        indicatorPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        tabs: [
          Tab(child: Text('Super Sunday')),
          Tab(child: Text('Icare')),
          Tab(
            child: Text(
              'Discipleship Journey',
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _buildPilihJenisJadwalDialog() {
    return Modal.baseBottomSheet(
      context,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tambah Jadwal").p18m().black2(),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                _onGoToCreateSuperSunday();
              },
              child: _buildJenisJadwal(title: "Super Sunday"),
            ),
            SizedBox(height: 12),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                _onGoToCreateIcare();
              },
              child: _buildJenisJadwal(title: "Icare"),
            ),
            SizedBox(height: 12),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                _onGoToCreateDiscipleshipJourney();
              },
              child: _buildJenisJadwal(title: "Discipleship Journey"),
            ),
          ],
        ),
      ),
    );
  }

  void _onGoToCreateSuperSunday({String? id, bool? isEdit}) async {
    final result = await context.push(
      RoutePath.createJadwalSuperSunday,
      extra: CreateAcaraParams(
        id: id ?? "",
        isEdit: isEdit ?? false,
      ),
    );

    if (result == true) {
      _onRefresh();
    }
  }

  void _onGoToCreateIcare({String? id, bool? isEdit}) async {
    final result = await context.push(
      RoutePath.createJadwalIcare,
      extra: CreateAcaraParams(
        id: id ?? "",
        isEdit: isEdit ?? false,
      ),
    );

    if (result == true) {
      _onRefresh();
    }
  }

  Widget _buildJenisJadwal({required String title}) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: BaseColor.white,
        border: Border.all(color: BaseColor.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
      ).p16r().black2(),
    );
  }
}
