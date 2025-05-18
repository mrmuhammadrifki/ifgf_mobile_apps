import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';

class NatsCard extends StatelessWidget {
  final String? date;
  final String? ayat;
  final String? isi;
  final Function() onEdit;
  final Function() onDelete;
  const NatsCard({
    super.key,
    this.date,
    this.ayat,
    this.isi,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: BaseColor.border,
          width: 1,
        ),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date?.formattedDate ?? "").p14r().grey2(),
          SizedBox(height: 8),
          Text('"${isi ?? ''}"').p16r().black2(),
          SizedBox(height: 8),
          Text("– ${ayat ?? ""}").p16sb().black2(),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: onDelete,
                child: SvgPicture.asset(
                  AssetsIcon.delete,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    BaseColor.icon,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 8),
              InkWell(
                onTap: onEdit,
                child: SvgPicture.asset(
                  AssetsIcon.edit,
                  width: 24,
                  height: 24,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
