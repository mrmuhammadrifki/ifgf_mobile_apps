import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/create_acara_params.dart';
import 'package:ifgf_apps/data/models/super_sunday_response.dart';
import 'package:ifgf_apps/presentation/pages/detail_jadwal/cubit/detail_jadwal_cubit.dart';
import 'package:ifgf_apps/presentation/pages/detail_jadwal/provider/detail_jadwal_provider.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';

import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/detail_event_shimmer.dart';

class DetailJadwal extends StatefulWidget {
  final String? id;
  const DetailJadwal({super.key, this.id});

  @override
  State<DetailJadwal> createState() => _DetailJadwalState();
}

class _DetailJadwalState extends State<DetailJadwal> {
  static final _keyLoader = GlobalKey<State>();
  Future<void> _onRefresh() async {
    if (widget.id?.isNotEmpty == true) {
      context.read<DetailJadwalCubit>().getAll(id: widget.id);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Detail Jadwal',
        showBackIcon: true,
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
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
            child: BlocBuilder<DetailJadwalCubit, DetailJadwalState>(
              builder: (context, state) {
                return state.when(
                  loading: () => DetailEventShimmer(),
                  silentLoading: (data) => _buildDetailJadwal(data),
                  loadingMore: (data) => _buildDetailJadwal(data),
                  success: (data) => _buildDetailJadwal(data),
                  failure: () => const Center(child: Text('Tidak ada data')),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onDeleteJadwal(String? id) async {
    final jadwalProvider = context.read<DetailJadwalProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await jadwalProvider.deleteJadwal(id: id);

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    if (!mounted) return;

    if (response is DataSuccess) {
      Navigator.pop(context, true);
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

  void _onGoToEditSuperSunday() async {
    final result = await context.push(
      RoutePath.createJadwalSuperSunday,
      extra: CreateAcaraParams(isEdit: true, id: widget.id ?? ""),
    );

    if (result == true) {
      await Future.delayed(Duration.zero);
      _onRefresh();
    }
  }

  Widget _buildDetailJadwal(SuperSundayResponse? item) {
    final provider = context.watch<ProfileProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: item?.thumbnail?.first?.url ?? "",
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item?.jenisJadwal ?? "").p24m().black2(),
              SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset(AssetsIcon.location),
                  SizedBox(width: 3),
                  Text(item?.location ?? "").p14m().grey2()
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  SvgPicture.asset(AssetsIcon.calendarBlue),
                  SizedBox(width: 3),
                  Text(item?.dateTime?.formattedDayDateTime() ?? "")
                      .p14m()
                      .grey2()
                ],
              ),
              SizedBox(height: 24),
              Text("Petugas").p18m().black2(),
              SizedBox(height: 8),
              _buildPetugas(
                job: "Preacher",
                names: item?.petugas?.preacher ?? "",
              ),
              SizedBox(height: 8),
              _buildPetugas(
                job: "Worship Leader",
                names: item?.petugas?.worshipLeader ?? "",
              ),
              SizedBox(height: 16),
              Text("Musik").p14m().black2(),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    _buildPetugas(
                      job: "Singer",
                      names: item?.petugas?.singer ?? "",
                    ),
                    SizedBox(height: 8),
                    _buildPetugas(
                      job: "Keyboard",
                      names: item?.petugas?.keyboard ?? "",
                    ),
                    SizedBox(height: 8),
                    _buildPetugas(
                      job: "Bass",
                      names: item?.petugas?.bas ?? "",
                    ),
                    SizedBox(height: 8),
                    _buildPetugas(
                      job: "Gitar",
                      names: item?.petugas?.gitar ?? "",
                    ),
                    SizedBox(height: 8),
                    _buildPetugas(
                      job: "Drum",
                      names: item?.petugas?.drum ?? "",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text("The Box").p14m().black2(),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    _buildPetugas(
                      job: "Multimedia",
                      names: item?.petugas?.multimedia ?? "",
                    ),
                    SizedBox(height: 8),
                    _buildPetugas(
                      job: "Dokumentasi",
                      names: item?.petugas?.dokumentasi ?? "",
                    ),
                    SizedBox(height: 8),
                    _buildPetugas(
                      job: "LCD Operator",
                      names: item?.petugas?.lcdOperator ?? "",
                    ),
                    SizedBox(height: 8),
                    _buildPetugas(
                      job: "Lighting",
                      names: item?.petugas?.lighting ?? "",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  provider.profile?.isAdmin ?? false
                      ? Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: BaseColor.red),
                            onPressed: () async {
                              final result = await Modal.showConfirmationDialog(
                                context,
                                title: "Hapus Jadwal",
                                message:
                                    "Apakah anda yakin ingin menghapus jadwal ini?",
                              );

                              if (result == true) {
                                _onDeleteJadwal(item?.id);
                              }
                            },
                            child: Text("Hapus"),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(width: provider.profile?.isAdmin ?? false ? 8 : 0),
                  provider.profile?.isAdmin ?? false
                      ? Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: BaseColor.blue),
                            onPressed: () {
                              _onGoToEditSuperSunday();
                            },
                            child: Text("Edit"),
                          ),
                        )
                      : SizedBox(),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPetugas({required String job, required String names}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(job).p14r().black2(),
        ),
        const Text(":").p14r().black2(),
        const SizedBox(width: 8),
        Expanded(
          child: Text(names).p14r().black2(),
        ),
      ],
    );
  }
}
