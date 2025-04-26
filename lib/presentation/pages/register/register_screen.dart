import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Pendaftaran",
        showBackIcon: true,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Jenis Pendaftaran").p18m().black2(),
            SizedBox(height: 16),
            InkWell(
              onTap: _onGoToJemaat,
              child: _buildMenuItem(title: "Jemaat Baru"),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: _onGoToMemberIcare,
              child: _buildMenuItem(title: "Icare"),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: _onGoToMemberDiscipleshipJourney,
              child: _buildMenuItem(title: "Discipleship Journey"),
            )
          ],
        ),
      ),
    );
  }

  void _onGoToJemaat() {
    context.push(RoutePath.jemaat);
  }

  void _onGoToMemberIcare() {
    context.push(RoutePath.memberIcare);
  }

  void _onGoToMemberDiscipleshipJourney() {
    context.push(RoutePath.memberDiscipleshipJourney);
  }

  Widget _buildMenuItem({required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BaseColor.border),
      ),
      child: Center(
        child: Text(title).p16r().black2(),
      ),
    );
  }
}
