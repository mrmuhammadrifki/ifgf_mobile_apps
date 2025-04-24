import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String location;
  final String dateTime;
  final String imageUrl;
  final List<Widget> actionButtons;
  const EventCard({
    super.key,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.imageUrl,
    required this.actionButtons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(AssetsImage.acaraExample),
        ),
        SizedBox(height: 8),
        Text(title).p18m().black2(),
        SizedBox(height: 8),
        Row(
          children: [
            SvgPicture.asset(AssetsIcon.location),
            SizedBox(width: 3),
            Text(location).p14m().grey2()
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            SvgPicture.asset(AssetsIcon.calendarBlue),
            SizedBox(width: 3),
            Text(dateTime).p14m().grey2()
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
