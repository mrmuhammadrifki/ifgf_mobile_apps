import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/presentation/widgets/custom_appbar_dark';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  final String image; 
  const PhotoViewPage({super.key, required this.image});

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      appBar: const CustomAppbarDark(
        titleText: '',
        showBackIcon: true,
        backIconAssets: AssetsIcon.icX,
      ),
      body: PhotoView(
        backgroundDecoration: const BoxDecoration(
          color: Color(0xFF1D1D1D),
        ),
        imageProvider: AssetImage(widget.image), // local asset image
      ),
    );
  }
}