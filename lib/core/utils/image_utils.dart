import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as developer;

class ImageUtils {
  static Future<XFile?> pickImage({required ImageSource source}) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: source);

    return _compressImage(pickedFile);
  }

  static Future<XFile?> _compressImage(XFile? file) async {
    developer.log("size then : ${await file?.length()}");

    final filePath = file?.path ?? "";
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 70,
          format: CompressFormat.png);

      developer.log("size now : ${await compressedImage?.length()}");

      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 70,
      );

      developer.log("size now : ${await compressedImage?.length()}");

      return compressedImage;
    }
  }

}
