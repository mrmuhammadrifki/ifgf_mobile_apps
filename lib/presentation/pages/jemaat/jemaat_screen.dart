import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/member_card.dart';

class JemaatScreen extends StatefulWidget {
  const JemaatScreen({super.key});

  @override
  State<JemaatScreen> createState() => _JemaatScreenState();
}

class _JemaatScreenState extends State<JemaatScreen> {
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
              isAdmin: false,
              onDelete: () async {
                final result = await Modal.showConfirmationDialog(
                  context,
                  title: "Hapus Jemaat",
                  message: "Apakah anda yakin ingin menghapus jemaat ini?",
                );
              },
              onEdit: () => _onGoToRegisterJemaat(isEdit: true),
            );
          },
        ),
      ),
    );
  }

  void _onGoToRegisterJemaat({bool? isEdit}) {
    context.push(RoutePath.registerJemaat, extra: isEdit);
  }
}
