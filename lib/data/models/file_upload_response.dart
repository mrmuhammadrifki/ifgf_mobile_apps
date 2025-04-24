class FileUploadResponse {
  String? path;
  String? url;
  FileUploadResponse({
    this.path,
    this.url,
  });

  FileUploadResponse copyWith({
    String? path,
    String? url,
  }) {
    return FileUploadResponse(
      path: path ?? this.path,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'url': url,
    };
  }

  factory FileUploadResponse.fromMap(Map<String, dynamic> map) {
    return FileUploadResponse(
      path: map['path'] != null ? map['path'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }
}
