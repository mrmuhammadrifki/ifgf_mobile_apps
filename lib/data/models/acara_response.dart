import 'package:ifgf_apps/data/models/image_response.dart';

class AcaraResponse {
  String? id;
  String? title;
  String? dateTime;
  String? location;
  List<ImageResponse?>? thumbnail;
  List<ImageResponse?>? poster;

  AcaraResponse({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.thumbnail,
    required this.poster,
  });

  factory AcaraResponse.fromMap(Map<String, dynamic> map) {
    return AcaraResponse(
      id: map['id'] as String,
      title: map['title'] as String,
      dateTime: map['date_time'] as String,
      location: map['location'] as String,
      thumbnail: (map['thumbnail'] as List<dynamic>)
          .map((e) => ImageResponse.fromMap(e as Map<String, dynamic>))
          .toList(),
      poster: (map['poster'] as List<dynamic>)
          .map((e) => ImageResponse.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date_time': dateTime,
      'location': location,
      'thumbnail': thumbnail?.map((e) => e?.toMap()).toList(),
      'poster': poster?.map((e) => e?.toMap()).toList(),
    };
  }
}
