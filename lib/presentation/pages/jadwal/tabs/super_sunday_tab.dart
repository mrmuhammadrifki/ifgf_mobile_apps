import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/presentation/widgets/event_card.dart';

class SuperSundayTab extends StatefulWidget {
  const SuperSundayTab({super.key});

  @override
  State<SuperSundayTab> createState() => _SuperSundayTabState();
}

class _SuperSundayTabState extends State<SuperSundayTab>
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
                title: "Super Sunday",
                location: "IFGF Purwokerto",
                dateTime: "Jumat, 18 April 2025 20.00",
                imageUrl: AssetsImage.acaraExample,
                actionButtons: _buildActionButton(),
              );
            },
          )),
    );
  }

  List<Widget> _buildActionButton() {
    return [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: BaseColor.blue),
          onPressed: () => _onGoToDetailJadwal(),
          child: Text("Lihat Detail"),
        ),
      ),
    ];
  }
  

  void _onGoToDetailJadwal() {
    context.push(RoutePath.detailJadwal);
  }
}
