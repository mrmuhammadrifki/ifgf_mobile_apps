import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/routes/navigation.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/image_utils.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/data_sources/local/shared_pref.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_storage_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/profile_firestore_service.dart';
import 'package:ifgf_apps/data/models/detail_profile_response.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:image_picker/image_picker.dart';

class RegisterJemaatProvider extends ChangeNotifier {
  final FirebaseStorageService _firebaseStorageService;
  final ProfileFirestoreService _profileFirestoreService;
  List<ImageResponse?> _imageSelected = [];

  List<ImageResponse?> get imageSelected => _imageSelected;

  RegisterJemaatProvider(
    this._firebaseStorageService,
    this._profileFirestoreService,
  );

  void addImage(ImageResponse? image) {
    if (image?.url != null && image?.filePath != null) {
      _imageSelected.add(image);
      notifyListeners();
    }
  }

  void selectImage({required int index}) async {
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
        );

        Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();

        if (response.url != null) {
          _imageSelected = [
            ImageResponse(
              url: response.url ?? "",
              filePath: response.path ?? "",
            )
          ];

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

  Future<DataState<bool>> updateJemaat({
    String? uid,
    String? fullName,
    DateTime? birthDate,
    String? phoneNumber,
    bool? isAdmin,
    ImageResponse? photoProfile,
  }) async {
    try {
      await _profileFirestoreService.updateProfile(
        uid: uid,
        fullName: fullName,
        birthDate: birthDate,
        phoneNumber: phoneNumber,
        isAdmin: isAdmin,
        photoProfile: photoProfile,
      );
      final detailProfileResponse = SharedPref.detailProfileResponse;
      debugPrint("ui: $uid - id ${detailProfileResponse?.id}");
      if (uid == detailProfileResponse?.id) {
        SharedPref.detailProfileResponse = detailProfileResponse?.copyWith(
          fullName: fullName,
          birthDate: birthDate?.toIso8601String(),
          photoProfile: [photoProfile],
          isAdmin: isAdmin,
          phoneNumber: phoneNumber,
        );
      }

      return DataSuccess(true);
    } catch (e) {
      return DataFailed('Gagal update data jemaat: ${e.toString()}');
    }
  }

  Future<DataState<DetailProfileResponse?>> getDetailJemaat(
      {String? id}) async {
    try {
      final result = await _profileFirestoreService.getDetailProfile(id ?? "");

      debugPrint(result.toString());

      return DataSuccess(result);
    } catch (e) {
      return DataFailed('Gagal mendapatkan data jemaat: ${e.toString()}');
    }
  }
}
