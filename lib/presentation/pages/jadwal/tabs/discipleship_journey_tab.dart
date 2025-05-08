import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/acara_response.dart';
import 'package:ifgf_apps/data/models/discipleship_journey_response.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:ifgf_apps/presentation/widgets/event_card.dart';
import 'package:provider/provider.dart';

class DiscipleshipJourneyTab extends StatefulWidget {
  final Function(String? id) onEdit;
  final Function(String? id) onDelete;
  final Function(DiscipleshipJourneyResponse?) onSharePoster;
  final List<DiscipleshipJourneyResponse> data;
  const DiscipleshipJourneyTab({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.onSharePoster,
    required this.data,
  });

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
    return Container(
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
        child: ListView.builder(
          itemCount: widget.data.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = widget.data[index];
            return EventCard(
              item: AcaraResponse(
                id: item.id,
                title: item.jenisDiscipleshipJourney,
                dateTime: item.dateTime,
                location: item.location,
                thumbnail: item.thumbnail,
                poster: item.poster,
              ),
              actionButtons: _buildActionButton(item: item),
            );
          },
        ));
  }

  List<Widget> _buildActionButton({DiscipleshipJourneyResponse? item}) {
    final provider = context.watch<ProfileProvider>();
    return [
      provider.profile?.isAdmin ?? false
          ? Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: BaseColor.red),
                onPressed: () async {
                  final result = await Modal.showConfirmationDialog(
                    context,
                    title: "Hapus Jadwal",
                    message: "Apakah anda yakin ingin menghapus jadwal ini?",
                  );

                  if (result == true) {
                    widget.onDelete(item?.id);
                  }
                },
                child: Text("Hapus"),
              ),
            )
          : SizedBox(),
      SizedBox(width: 8),
      provider.profile?.isAdmin ?? false
          ? Expanded(
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: BaseColor.yellow),
                onPressed: () => widget.onEdit(item?.id),
                child: Text("Edit"),
              ),
            )
          : SizedBox(),
      SizedBox(width: provider.profile?.isAdmin ?? false ? 8 : 0),
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: BaseColor.blue),
          onPressed: item?.poster?.first?.filePath.isNotEmpty ?? true
              ? () => widget.onSharePoster(item)
              : null,
          child: Text("Bagikan"),
        ),
      ),
    ];
  }
}
