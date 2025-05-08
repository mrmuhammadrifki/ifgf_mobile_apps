import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String? jenisMember;
  final bool? isAdmin;
  final ImageResponse? photoProfile;
  final Function() onEdit;
  final Function() onDelete;
  const MemberCard({
    super.key,
    required this.name,
    this.jenisMember,
    this.photoProfile,
    this.isAdmin,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
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
                photoProfile == null || photoProfile?.url.isEmpty == true
                    ? Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: BaseColor.border,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            name.getInitials,
                          ).p16m().black2(),
                        ),
                      )
                    : ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: photoProfile?.url ?? "",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAdmin ?? false ? '$name (Admin)' : name,
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
              if (jenisMember != null)
                provider.profile?.isAdmin ?? false
                    ? InkWell(
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
                      )
                    : SizedBox(),
              SizedBox(width: 8),
              provider.profile?.isAdmin ?? false
                  ? InkWell(
                      onTap: onEdit,
                      child: SvgPicture.asset(
                        AssetsIcon.edit,
                        width: 24,
                        height: 24,
                      ),
                    )
                  : SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
