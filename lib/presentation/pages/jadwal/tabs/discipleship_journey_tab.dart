import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/widgets/event_card.dart';

class DiscipleshipJourneyTab extends StatefulWidget {
  const DiscipleshipJourneyTab({super.key});

  @override
  State<DiscipleshipJourneyTab> createState() => _DiscipleshipJourneyTabState();
}

class _DiscipleshipJourneyTabState extends State<DiscipleshipJourneyTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Container(
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
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return EventCard(
                title: "Discepliship Journey (Com) ",
                location: "IFGF Purwokerto",
                dateTime: "Jumat, 18 April 2025 20.00",
                imageUrl: AssetsImage.acaraExample,
                actionButtons: _buildActionButton(),
              );
            },
          )),
    );
  }

  void _onGoToEditDiscipleshipJourney() {
    context.push(RoutePath.createJadwalDiscipleshipJourney, extra: true);
  }

  List<Widget> _buildActionButton() {
    return [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: BaseColor.red),
          onPressed: () async {
            final result = await Modal.showConfirmationDialog(
              context,
              title: "Hapus Jadwal",
              message: "Apakah anda yakin ingin menghapus jadwal ini?",
            );
          },
          child: Text("Hapus"),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: BaseColor.blue),
          onPressed: () => _onGoToEditDiscipleshipJourney(),
          child: Text("Edit"),
        ),
      ),
    ];
  }
}
