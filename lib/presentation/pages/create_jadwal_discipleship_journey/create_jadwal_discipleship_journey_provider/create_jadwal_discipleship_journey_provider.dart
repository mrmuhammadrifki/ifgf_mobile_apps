import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/routes/navigation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/image_utils.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_storage_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/jadwal_firestore_service.dart';
import 'package:ifgf_apps/data/models/discipleship_journey_response.dart';
import 'package:ifgf_apps/data/models/file_upload_response.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:image_picker/image_picker.dart';

class CreateJadwalDiscipleshipJourneyProvider extends ChangeNotifier {
  final FirebaseStorageService _firebaseStorageService;
  final JadwalFirestoreService _jadwalFirestoreService;
  final List<FileUploadResponse?> _imageSelected = [];

  List<FileUploadResponse?> get imageSelected => _imageSelected;

  void addImage(FileUploadResponse? image) {
    if (image?.url != null && image?.path != null) {
      _imageSelected.add(image);
      notifyListeners();
    }
  }

  CreateJadwalDiscipleshipJourneyProvider(
      this._firebaseStorageService, this._jadwalFirestoreService);

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

  Future<DataState<bool>> createJadwal({
    String? dateTime,
    String? jenisDisciplehsipJourney,
    String? location,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      await _jadwalFirestoreService.createJadwalDiscipleshipJourney(
        jenisDiscipleshipJourney: jenisDisciplehsipJourney,
        dateTime: dateTime,
        location: location,
        thumbnail: thumbnail,
        poster: poster,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal menyimpan data jadwal: ${e.toString()}');
    }
  }

  Future<DataState<DiscipleshipJourneyResponse?>> getOneJadwal(
      {String? id}) async {
    try {
      debugPrint(id.toString());
      final result =
          await _jadwalFirestoreService.getOneDiscipleshipJourney(id: id);

      return DataSuccess(result);
    } catch (e) {
      return DataFailed('Gagal mendapatkan data jadwal: ${e.toString()}');
    }
  }

  Future<DataState<bool>> updateJadwal({
    required String id,
    String? jenisDiscipleshipJourney,
    String? dateTime,
    String? location,
    ImageResponse? thumbnail,
    ImageResponse? poster,
  }) async {
    try {
      await _jadwalFirestoreService.updateJadwal(
        id: id,
        jenisDiscipleshipJourney: jenisDiscipleshipJourney,
        dateTime: dateTime,
        location: location,
        thumbnail: thumbnail,
        poster: poster,
      );

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal update data jadwal: ${e.toString()}');
    }
  }
}
