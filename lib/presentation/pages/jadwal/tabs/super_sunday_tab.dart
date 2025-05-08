import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/data/models/acara_response.dart';
import 'package:ifgf_apps/data/models/super_sunday_response.dart';
import 'package:ifgf_apps/presentation/widgets/event_card.dart';

class SuperSundayTab extends StatefulWidget {
  final Function(String id) onDetail;
  final Function(SuperSundayResponse?) onSharePoster;
  final List<SuperSundayResponse> data;
  const SuperSundayTab({
    super.key,
    required this.onDetail,
    required this.onSharePoster,
    required this.data,
  });

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
                title: item.jenisJadwal,
                dateTime: item.dateTime,
                location: item.location,
                thumbnail: item.thumbnail,
                poster: item.poster,
              ),
              actionButtons: _buildActionButton(item),
            );
          },
        ));
  }

  List<Widget> _buildActionButton(SuperSundayResponse? item) {
    return [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: BaseColor.black2,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: BaseColor.border),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => widget.onDetail(item?.id ?? ""),
          child: Text("Lihat Detail"),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: BaseColor.blue),
          onPressed: item?.poster?.first?.filePath.isNotEmpty == true
              ? () => widget.onSharePoster(item)
              : null,
          child: Text("Bagikan"),
        ),
      ),
    ];
  }
}
