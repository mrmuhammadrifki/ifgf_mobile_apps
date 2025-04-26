import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/member_card.dart';

class MemberDiscipleshipJourneyScreen extends StatefulWidget {
  const MemberDiscipleshipJourneyScreen({super.key});

  @override
  State<MemberDiscipleshipJourneyScreen> createState() =>
      _MemberDiscipleshipJourneyScreenState();
}

class _MemberDiscipleshipJourneyScreenState
    extends State<MemberDiscipleshipJourneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Member Discipleship Journey",
        showBackIcon: true,
        suffixWidget: [
          TextButton(
            onPressed: _onGoToRegisterDiscipleshipJourney,
            child: Text("Tambah").p18sm().blue(),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
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
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return MemberCard(
              name: "Juwita Kristiani Hia",
              jenisMember: "Com",
              isAdmin: false,
              onDelete: () async {
                final result = await Modal.showConfirmationDialog(
                  context,
                  title: "Hapus Member",
                  message: "Apakah anda yakin ingin menghapus member ini?",
                );
              },
              onEdit: () => _onGoToRegisterDiscipleshipJourney(isEdit: true),
            );
          },
        ),
      ),
    );
  }

  void _onGoToRegisterDiscipleshipJourney({bool? isEdit}) {
    context.push(RoutePath.registerDiscipleshipJourney, extra: isEdit);
  }
}
