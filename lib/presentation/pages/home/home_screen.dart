import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: BaseColor.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.softBlue,
      body: Column(
        children: [
          _buildHeroSection(),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: BaseColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
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
                  Text("Shalom,").p16r().black2(),
                  Text("Juwita Kristiani Hia 👋").p24m(),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _onGoToAcara,
                          child: _buildMenuItem(
                            title: "Acara",
                            icon: AssetsIcon.event,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: InkWell(
                          onTap: _onGoToJadwal,
                          child: _buildMenuItem(
                            title: "Jadwal",
                            icon: AssetsIcon.jadwal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _onGoToKeuangan,
                          child: _buildMenuItem(
                            title: "Keuangan",
                            icon: AssetsIcon.money,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: InkWell(
                          onTap: _onGoToPendaftaran,
                          child: _buildMenuItem(
                            title: "Pendaftaran Pastorit",
                            icon: AssetsIcon.register,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onGoToKeuangan() {
    context.push(RoutePath.keuangan);
  }

  void _onGoToAcara() {
    context.push(RoutePath.acara);
  }

  void _onGoToJadwal() {
    context.push(RoutePath.jadwal);
  }

  void _onGoToPendaftaran() {
    context.push(RoutePath.register);
  }

  Widget _buildMenuItem({required String icon, required String title}) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: BaseColor.white,
        border: Border.all(color: BaseColor.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center).p16m().black2()
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            AssetsImage.heroBg,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsImage.logoDark, width: 86.0),
                SizedBox(height: 8),
                Text('IFGF Purwokerto').p18b().white()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
