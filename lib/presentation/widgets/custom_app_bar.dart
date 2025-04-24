import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/presentation/widgets/custom_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final bool showBackIcon;
  final void Function()? onTapBack;
  final String? backIconAssets;
  final List<Widget>? suffixWidget;
  final Color? appBarColor;
  final bool? isDarkAppbar;
  const CustomAppBar({
    super.key,
    required this.titleText,
    this.showBackIcon = false,
    this.onTapBack,
    this.suffixWidget,
    this.backIconAssets,
    this.appBarColor,
    this.isDarkAppbar,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, preferredSize.height),
      child: AppBar(
        backgroundColor: appBarColor ?? Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: preferredSize.height,
        titleSpacing: 0,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 20, left: 5, bottom: 16),
          child: Row(
            children: <Widget>[
              if (showBackIcon)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    onPressed: () {
                      if (onTapBack != null) {
                        onTapBack!();
                        return;
                      }

                      if (context.canPop()) {
                        context.pop();
                        return;
                      }
                    },
                    icon: SvgPicture.asset(
                      backIconAssets ?? AssetsIcon.icX,
                    ),
                  ),
                )
              else if (suffixWidget != null)
                const CustomIconButton(),
              Expanded(
                child: Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: BaseColor.black2),
                ).p18sm(),
              ),
              if (suffixWidget != null)
                ...suffixWidget!
              else if (showBackIcon)
                const CustomIconButton(),
            ],
          ),
        ),
      ),
    );
  }
}
