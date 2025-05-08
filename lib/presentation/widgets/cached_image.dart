import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatefulWidget {
  final String url;
  final double height;
  final double width;
  final BoxFit? fit;
  final Widget? errorWidget;

  const CachedImage({
    super.key,
    required this.url,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit,
    this.errorWidget,
  });

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Image.asset(
          AssetsImage.acaraExample,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.cover,
        ),
      ),
      errorWidget: (context, url, error) => widget.errorWidget != null
          ? widget.errorWidget ?? const SizedBox()
          : Container(
              decoration: BoxDecoration(
                color: BaseColor.grey.shade300,
              ),
            ),
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      fit: widget.fit ?? BoxFit.cover,
      height: widget.height,
      width: widget.width,
    );
  }
}
