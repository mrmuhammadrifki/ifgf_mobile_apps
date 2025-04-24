import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/tabs/discipleship_journey_tab.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/tabs/icare_tab.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/tabs/super_sunday_tab.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Jadwal",
        showBackIcon: true,
        suffixWidget: [
          TextButton(
            onPressed: () => _buildPilihJenisJadwalDialog(),
            child: Text("Tambah").p18sm().blue(),
          )
        ],
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
                  SuperSundayTab(),
                  IcareTab(),
                  DiscipleshipJourneyTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  void _onGoToCreateSuperSunday() {
    context.push(RoutePath.createSuperSunday);
  }

  void _onGoToCreateIcare() {
    context.push(RoutePath.createIcare);
  }

  void _onGoToCreateDiscipleshipJourney() {
    context.push(RoutePath.createDiscipleshipJourney);
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
