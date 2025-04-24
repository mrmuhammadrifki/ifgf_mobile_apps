import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconButton extends StatelessWidget {
  final String? svgAssets;
  final void Function()? onTap;
  const CustomIconButton({super.key, this.svgAssets, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (svgAssets == null) return const SizedBox(width: 44, height: 44);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: SvgPicture.asset(svgAssets!)),
      ),
    );
  }
}
