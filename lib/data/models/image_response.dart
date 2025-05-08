class ImageResponse {
  final String url;
  final String filePath;

  ImageResponse({
    required this.url,
    required this.filePath,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(
      url: json['url'] as String,
      filePath: json['file_path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'file_path': filePath,
    };
  }

  factory ImageResponse.fromMap(Map<String, dynamic> map) {
    return ImageResponse(
      url: map['url'] as String,
      filePath: map['file_path'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'file_path': filePath,
    };
  }
}
