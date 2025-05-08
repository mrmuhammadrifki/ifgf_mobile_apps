import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/data/models/acara_response.dart';

class EventCard extends StatelessWidget {
  final AcaraResponse? item;
  final List<Widget> actionButtons;
  const EventCard({
    super.key,
    this.item,
    required this.actionButtons
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: item?.thumbnail?.first?.url ?? "",
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Text(item?.title ?? "").p18m().black2(),
        SizedBox(height: 8),
        Row(
          children: [
            SvgPicture.asset(AssetsIcon.location),
            SizedBox(width: 3),
            Text(item?.location ?? "").p14m().grey2()
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            SvgPicture.asset(AssetsIcon.calendarBlue),
            SizedBox(width: 3),
            Text(item?.dateTime?.formattedDayDateTime() ?? "").p14m().grey2()
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: actionButtons,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
