import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/acara_response.dart';
import 'package:ifgf_apps/data/models/icare_response.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:ifgf_apps/presentation/widgets/event_card.dart';
import 'package:provider/provider.dart';

class IcareTab extends StatefulWidget {
  final Function(String? id) onEdit;
  final Function(String? id) onDelete;
  final Function(IcareResponse?) onSharePoster;
  final List<IcareResponse> data;
  const IcareTab({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.onSharePoster,
    required this.data,
  });

  @override
  State<IcareTab> createState() => _IcareTabState();
}

class _IcareTabState extends State<IcareTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
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
                title: item.jenisIcare,
                dateTime: item.dateTime,
                location: item.location,
                thumbnail: item.thumbnail,
                poster: item.poster,
              ),
              actionButtons: _buildActionButton(
                item: item,
                isAdmin: provider.profile?.isAdmin,
              ),
            );
          },
        ));
  }

  List<Widget> _buildActionButton({IcareResponse? item, bool? isAdmin}) {
    return [
      isAdmin ?? false
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
      SizedBox(width: isAdmin ?? false ? 8 : 0),
      isAdmin ?? false
          ? Expanded(
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: BaseColor.yellow),
                onPressed: () => widget.onEdit(item?.id),
                child: Text("Edit"),
              ),
            )
          : SizedBox(),
      SizedBox(width: isAdmin ?? false ? 8 : 0),
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
