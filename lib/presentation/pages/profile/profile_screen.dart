import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 32),
              Text("Pengaturan Akun").p18m().black2(),
              SizedBox(height: 16),
              _buildMenuItem(title: "Tentang Kami"),
              SizedBox(height: 8),
              _buildMenuItem(title: "Ubah Profil"),
              SizedBox(height: 8),
              _buildMenuItem(title: "Hubungi Admin"),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaseColor.red,
                  ),
                  onPressed: () {},
                  child: Text("Keluar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: BaseColor.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BaseColor.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title).p16r().black2(),
          SvgPicture.asset(AssetsIcon.arrowRight)
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: BaseColor.border,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text("J").p28m(),
            ),
          ),
          SizedBox(height: 8),
          Text("Juwita Kristiani Hia").p16m().black2(),
          Text("Admin").p16r().grey2(),
        ],
      ),
    );
  }
}
