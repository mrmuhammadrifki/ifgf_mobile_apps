import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/routes/navigation.dart';
import 'package:ifgf_apps/core/utils/image_utils.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/file_upload_response.dart';
import 'package:image_picker/image_picker.dart';

class CreateDiscipleshipJourneyProvider extends ChangeNotifier {
  final List<FileUploadResponse> _imageSelected = [];
  List<FileUploadResponse> get imageSelected => _imageSelected;

  void selectImage({required int index}) async {
    if (_imageSelected.length > 1) return;

    final keyLoader = GlobalKey<State>();
    final context = Navigation.context;

    try {
      XFile? pickedFile = await ImageUtils.pickImage(
        source: index == 0 ? ImageSource.camera : ImageSource.gallery,
      );

      log("picked file : $pickedFile");

      if (pickedFile != null) {
        if (!context.mounted) return;
        Modal.showLoadingDialog(context, keyLoader);

        // final response = await ExploreRepository().upload(
        //   fileName: pickedFile.name,
        //   filePath: pickedFile.path,
        // );
        Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();

        // if (response is DataSuccess) {
        //   _imageSelected.add(response.data!);
        //   notifyListeners();

        //   if (!context.mounted) return;

        //   Modal.showInfoFlushbar(
        //     context,
        //     type: FlushbarType.Succes,
        //     message: "Berhasil memilih gambar",
        //   );
        // }

        // ///
        // else {
        //   if (!context.mounted) return;

        //   Modal.showInfoFlushbar(
        //     context,
        //     type: FlushbarType.Error,
        //     message: "Gagal memilih gambar",
        //   );
        // }
      }
    } catch (e) {
      log("$e", stackTrace: StackTrace.current);
    }
  }
}
