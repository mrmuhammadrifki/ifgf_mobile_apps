import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/auth_utils.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/provider/firebase_auth_provider.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final detailProfileResponse = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: CustomAppBar(titleText: "Akun Saya"),
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
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 32),
                  Text("Pengaturan Akun").p18m().black2(),
                  SizedBox(height: 16),
                  InkWell(
                      onTap: _onGoToTentangKami,
                      child: _buildMenuItem(title: "Tentang Kami")),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () => _onGoToEditProfile(
                      id: detailProfileResponse.profile?.id,
                    ),
                    child: _buildMenuItem(title: "Ubah Profil"),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: _onGoToKelolaNats,
                    child: _buildMenuItem(title: "Kelola Nats"),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                      onTap: () {
                        Helper.openWhatsApp(
                          phoneNumber: "6281263175915",
                          message: "Halo Admin IFGF, saya ingin bertanya",
                        );
                      },
                      child: _buildMenuItem(title: "Hubungi Admin")),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColor.red,
                      ),
                      onPressed: _onSignOut,
                      child: Text("Keluar"),
                    ),
                  )
                ],
              ),
            ),
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

  void _onSignOut() {
    AuthUtils.signOut(
      onSuccess: () async {
        final authProvider = context.read<FirebaseAuthProvider>();
        final result = await authProvider.signOut();
        if (result is DataSuccess) {
          if (!mounted) return;
          context.go(RoutePath.login);
          Modal.showSnackBar(context,
              snackbarType: SnackbarType.success, text: "Berhasil keluar!");
        } else {
          if (!mounted) return;
          final errorMessage = result.error?.toString() ??
              "Terjadi kesalahan, silakan coba lagi.";
          Modal.showSnackBar(
            context,
            text: errorMessage,
            snackbarType: SnackbarType.danger,
          );
        }
      },
    );
  }

  void _onGoToKelolaNats() {
    context.push(RoutePath.nats);
  }

  void _onGoToEditProfile({String? id}) async {
    final result = await context.push(RoutePath.editProfile, extra: id);

    if (result == true) {
      _onRefresh();
    }
  }

  void _onGoToTentangKami() {
    context.push(RoutePath.tentangKami);
  }

  Future<void> _onRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = context.read<ProfileProvider>();
      provider.reload();
    });
  }

  Widget _buildHeader() {
    final detailProfileResponse = context.watch<ProfileProvider>();
    return Center(
      child: Column(
        children: [
          detailProfileResponse.profile?.photoProfile?.first?.url.isEmpty ==
                  true
              ? Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: BaseColor.border,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      detailProfileResponse.profile?.fullName.getInitials ??
                          "Foto",
                    ).p28m().black2(),
                  ),
                )
              : ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: detailProfileResponse
                            .profile?.photoProfile?.first?.url ??
                        "",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
          SizedBox(height: 8),
          Text(detailProfileResponse.profile?.fullName ?? "").p16m().black2(),
          Text(detailProfileResponse.profile?.isAdmin == true
                  ? "Admin"
                  : "Jemaat")
              .p16r()
              .grey2(),
        ],
      ),
    );
  }
}
