import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/create_acara_params.dart';
import 'package:ifgf_apps/data/models/detail_profile_response.dart';
import 'package:ifgf_apps/presentation/pages/jemaat/cubit/list_jemaat_cubit.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/list_user_shimmer.dart';
import 'package:ifgf_apps/presentation/widgets/member_card.dart';

class JemaatScreen extends StatefulWidget {
  const JemaatScreen({super.key});

  @override
  State<JemaatScreen> createState() => _JemaatScreenState();
}

class _JemaatScreenState extends State<JemaatScreen> {
  Future<void> _onRefresh() async {
    context.read<ListJemaatCubit>().getAll();
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
        titleText: "Jemaat",
        showBackIcon: true,
        suffixWidget: [
          TextButton(
            onPressed: _onGoToRegisterJemaat,
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
          child: BlocBuilder<ListJemaatCubit, ListJemaatState>(
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

  Widget _buildList(List<DetailProfileResponse> data) {
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
              name: item.fullName,
              isAdmin: item.isAdmin,
              photoProfile: item.photoProfile?.first,
              onDelete: () async {
                final result = await Modal.showConfirmationDialog(
                  context,
                  title: "Hapus Jemaat",
                  message: "Apakah anda yakin ingin menghapus jemaat ini?",
                );
              },
              onEdit: () => _onGoToRegisterJemaat(isEdit: true, id: item.id),
            );
          },
        ),
      ],
    );
  }

  void _onGoToRegisterJemaat({bool? isEdit, String? id}) async {
    debugPrint(id);
    final result = await context.push(
      RoutePath.registerJemaat,
      extra: CreateAcaraParams(
        isEdit: isEdit ?? false,
        id: id ?? "",
      ),
    );

    if (result == true) {
      _onRefresh();
    }
  }
}
