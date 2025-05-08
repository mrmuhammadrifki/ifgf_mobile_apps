import 'package:ifgf_apps/core/utils/enum.dart';

class FileUploadResponse {
  String? path;
  String? url;
  ImageType? imageType;
  FileUploadResponse({this.path, this.url, this.imageType});

  FileUploadResponse copyWith({
    String? path,
    String? url,
    ImageType? imageType,
  }) {
    return FileUploadResponse(
      path: path ?? this.path,
      url: url ?? this.url,
      imageType: imageType ?? this.imageType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'url': url,
      'imageType': imageType,
    };
  }

  factory FileUploadResponse.fromMap(Map<String, dynamic> map) {
    return FileUploadResponse(
      path: map['path'] != null ? map['path'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      imageType:
          map['imageType'] != null ? map['imageType'] as ImageType : null,
    );
  }
}
