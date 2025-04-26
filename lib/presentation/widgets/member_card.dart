import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String? jenisMember;
  final bool isAdmin;
  final Function() onEdit;
  final Function() onDelete;
  const MemberCard({
    super.key,
    required this.name,
    this.jenisMember,
    required this.isAdmin,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: BaseColor.border,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text("J").p16m(),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAdmin ? '$name (Admin)' : name,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ).p14m().black2(),
                      if (jenisMember != null) SizedBox(height: 2),
                      if (jenisMember != null)
                        Text(jenisMember ?? "").p12m().grey2()
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
