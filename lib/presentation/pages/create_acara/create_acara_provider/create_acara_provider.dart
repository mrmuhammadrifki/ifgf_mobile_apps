import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/routes/navigation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/image_utils.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/data_sources/remote/acara_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_storage_service.dart';
import 'package:ifgf_apps/data/models/acara_response.dart';
import 'package:ifgf_apps/data/models/file_upload_response.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:image_picker/image_picker.dart';

class CreateAcaraProvider extends ChangeNotifier {
  final FirebaseStorageService _firebaseStorageService;
  final AcaraFirestoreService _acaraFirestoreService;
  final List<FileUploadResponse?> _imageSelected = [];

  List<FileUploadResponse?> get imageSelected => _imageSelected;

  void addImage(FileUploadResponse? image) {
    if (image?.url != null && image?.path != null) {
      _imageSelected.add(image);
      notifyListeners();
    }
  }

  CreateAcaraProvider(
      this._firebaseStorageService, this._acaraFirestoreService);

  void selectImage({required int index, required ImageType imageType}) async {
    if (_imageSelected.any((image) => image?.imageType == imageType)) {
      Modal.showSnackBar(
        Navigation.context,
        snackbarType: SnackbarType.warning,
        text:
            "Gambar ${imageType == ImageType.thumbnails ? 'thumbnail' : 'poster'} sudah dipilih",
      );
      return;
    }

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

        final response = await _firebaseStorageService.upload(
          fileName: pickedFile.name,
          filePath: pickedFile.path,
          imageType: imageType,
        );

        Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();

        if (response.url != null) {
          _imageSelected.add(response);
          notifyListeners();

          if (!context.mounted) return;

          Modal.showSnackBar(
            context,
            snackbarType: SnackbarType.success,
            text: "Berhasil memilih gambar",
          );
        }

        ///
        else {
          if (!context.mounted) return;

          Modal.showSnackBar(
            context,
            snackbarType: SnackbarType.danger,
            text: "Gagal memilih gambar",
          );
        }
      }
    } catch (e) {
      log("$e", stackTrace: StackTrace.current);
    }
  }

  void removeImage(int index) {
    _imageSelected.removeAt(index);
    notifyListeners();
  }

  FileUploadResponse? getThumbnail() {
    final result = _imageSelected.where(
      (image) => image?.imageType == ImageType.thumbnails,
    );
    return result.isNotEmpty ? result.first : null;
  }

  FileUploadResponse? getPoster() {
    final result = _imageSelected.where(
      (image) => image?.imageType == ImageType.posters,
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<DataState<bool>> createAcara({
    String? title,
    String? dateTime,
    String? location,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      await _acaraFirestoreService.createAcara(
          title: title,
          dateTime: dateTime,
          location: location,
          thumbnail: thumbnail,
          poster: poster);

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal menyimpan data acara: ${e.toString()}');
    }
  }

  Future<DataState<bool>> updateAcara({
    required String id,
    String? title,
    String? dateTime,
    String? location,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      await _acaraFirestoreService.updateAcara(
          id: id,
          title: title,
          dateTime: dateTime,
          location: location,
          thumbnail: thumbnail,
          poster: poster);

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal update data acara: ${e.toString()}');
    }
  }

  Future<DataState<AcaraResponse?>> getOneAcara({String? id}) async {
    try {
      final result = await _acaraFirestoreService.getOneAcara(id: id);

      debugPrint(result.toString());

      return DataSuccess(result);
    } catch (e) {
      return DataFailed('Gagal mendapatkan data acara: ${e.toString()}');
    }
  }
}
