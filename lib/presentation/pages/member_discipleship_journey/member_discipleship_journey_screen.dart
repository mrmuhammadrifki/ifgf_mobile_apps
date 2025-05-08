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
import 'package:ifgf_apps/data/models/member_discipleship_journey_response.dart';
import 'package:ifgf_apps/presentation/pages/member_discipleship_journey/cubit/list_member_discipleship_journey_cubit.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:ifgf_apps/presentation/pages/register_discipleship_journey/provider/register_discipleship_journey_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/list_user_shimmer.dart';
import 'package:ifgf_apps/presentation/widgets/member_card.dart';

class MemberDiscipleshipJourneyScreen extends StatefulWidget {
  const MemberDiscipleshipJourneyScreen({super.key});

  @override
  State<MemberDiscipleshipJourneyScreen> createState() =>
      _MemberDiscipleshipJourneyScreenState();
}

class _MemberDiscipleshipJourneyScreenState
    extends State<MemberDiscipleshipJourneyScreen> {
  static final _keyLoader = GlobalKey<State>();
  Future<void> _onRefresh() async {
    context.read<ListMemberDiscipleshipJourneyCubit>().getAll();
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
      appBar: CustomAppBar(
        titleText: "Member Discipleship Journey",
        showBackIcon: true,
        suffixWidget: [
          TextButton(
            onPressed: _onGoToRegisterDiscipleshipJourney,
            child:
                Text(provider.profile?.isAdmin ?? false ? "Tambah" : "Daftar")
                    .p18sm()
                    .blue(),
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
          child: BlocBuilder<ListMemberDiscipleshipJourneyCubit,
              ListMemberDiscipleshipJourneyState>(
            builder: (context, state) {
              return state.when(
                loading: () => ListUserShimmer(),
                success: (data) => _buildList(data),
                failure: () => const Center(child: Text('Tidak ada data')),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<MemberDiscipleshipJourneyResponse> data) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Anggota").p18m().black2(),
            Text("(${data.length} orang)").p16r().black2(),
          ],
        ),
        SizedBox(height: 24),
        ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = data[index];
            return MemberCard(
              name: item.fullName ?? "",
              jenisMember: item.jenisDiscipleshipJourney ?? "",
              onDelete: () async {
                final result = await Modal.showConfirmationDialog(
                  context,
                  title: "Hapus Member",
                  message: "Apakah anda yakin ingin menghapus member ini?",
                );

                if (result == true) {
                  await _onDeleteMemberDiscipleshipJourney(item.id);
                  _onRefresh();
                }
              },
              onEdit: () =>
                  _onGoToRegisterDiscipleshipJourney(isEdit: true, id: item.id),
            );
          },
        ),
      ],
    );
  }

  void _onGoToRegisterDiscipleshipJourney({bool? isEdit, String? id}) async {
    final result = await context.push(
      RoutePath.registerDiscipleshipJourney,
      extra: CreateAcaraParams(isEdit: isEdit ?? false, id: id ?? ""),
    );

    if (result == true) {
      _onRefresh();
    }
  }

  Future<void> _onDeleteMemberDiscipleshipJourney(String? id) async {
    final provider = context.read<RegisterDiscipleshipJourneyProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await provider.deleteMemberDiscipleshipJourney(id: id);

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    if (!mounted) return;

    if (response is DataSuccess) {
      Modal.showSnackBar(
        context,
        text: "Berhasil menghapus member discipleship journey",
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
