import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/data/models/file_upload_response.dart';
import 'package:ifgf_apps/data/models/petugas.dart';
import 'package:ifgf_apps/data/repository/upload_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FirebaseStorageService implements UploadRepository {
  final FirebaseStorage _firebaseStorage;

  FirebaseStorageService(
    FirebaseStorage? firebaseStorage,
  ) : _firebaseStorage = firebaseStorage ??= FirebaseStorage.instance;

  @override
  Future<FileUploadResponse> upload({
    String? filePath,
    String? fileName,
    ImageType? imageType,
  }) async {
    try {
      final storageRef = _firebaseStorage
          .ref()
          .child("${imageType != null ? imageType.name : "uploads"}/$fileName");
      final file = File(filePath ?? "");

      final uploadTask = storageRef.putFile(file);

      final snapshot = await uploadTask.whenComplete(() => null);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      final filePathResult = snapshot.ref.fullPath;

      return FileUploadResponse(
        url: downloadUrl,
        path: filePathResult,
        imageType: imageType,
      );
    } on FirebaseException catch (e) {
      throw Exception('Gagal upload file: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal upload file: ${e.toString()}');
    }
  }

  @override
  Future<void> sharePoster({
    String? filePath,
    String? title,
    String? location,
    String? dateTime,
    Petugas? petugas,
  }) async {
    try {
      if (filePath == null || filePath.isEmpty) {
        throw Exception('Path file tidak valid.');
      }

      final storageRef = _firebaseStorage.ref().child(filePath);
      final appDocDir = await getTemporaryDirectory();
      final localFilePath = '${appDocDir.path}/${filePath.split('/').last}';
      final file = File(localFilePath);

      final downloadTask = storageRef.writeToFile(file);
      final snapshot = await downloadTask;

      if (snapshot.state != TaskState.success) {
        debugPrint('Gagal mengunduh file dari Firebase Storage.');
        throw Exception('Gagal mengunduh file dari Firebase Storage.');
      }

      if (!await file.exists()) {
        debugPrint('File tidak ditemukan setelah diunduh.');
        throw Exception('File tidak ditemukan setelah diunduh.');
      }

      String? message;

      if (petugas == null) {
        message = '''
✨ SHALOM IFGFers! ✨
Ada kabar sukacita buat kita semua! 😇 Yuk catat dan hadir di acara spesial berikut ini:

📌 Nama Acara: $title
📍 Tempat: $location
🗓️ Waktu: $dateTime

📷 Cek posternya untuk info lengkap!
Jangan datang sendiri ya—ajak teman, keluarga, dan komunitasmu! ❤️

🙏 Sampai ketemu dan mari bertumbuh bersama dalam kasih Tuhan!
''';
      } else {
        message = '''
✨ SHALOM IFGFers! ✨
Ada kabar sukacita buat kita semua! 😇 Yuk catat dan hadir di acara spesial berikut ini:

📌 Nama Acara: $title
📍 Tempat: $location
🗓️ Waktu: $dateTime

🎤 Petugas Pelayanan:
- Preacher: ${petugas.preacher ?? '-'}
- Singer: ${petugas.singer ?? '-'}
- Keyboard: ${petugas.keyboard ?? '-'}
- Bas: ${petugas.bas ?? '-'}
- Gitar: ${petugas.gitar ?? '-'}
- Drum: ${petugas.drum ?? '-'}
- Multimedia: ${petugas.multimedia ?? '-'}
- Dokumentasi: ${petugas.dokumentasi ?? '-'}
- LCD Operator: ${petugas.lcdOperator ?? '-'}
- Lighting: ${petugas.lighting ?? '-'}

📷 Cek posternya untuk info lengkap!
Jangan datang sendiri ya—ajak teman, keluarga, dan komunitasmu! ❤️

🙏 Sampai ketemu dan mari bertumbuh bersama dalam kasih Tuhan!
''';
      }

      final params = ShareParams(
        text: message,
        files: [XFile(localFilePath)],
      );

      final result = await SharePlus.instance.share(params);
      if (result.status == ShareResultStatus.success) {
        debugPrint('Thank you for sharing the picture!');
      }
    } on FirebaseException catch (e) {
      throw Exception('Gagal download file: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal membagikan poster: ${e.toString()}');
    }
  }
}
