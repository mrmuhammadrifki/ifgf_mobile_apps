import 'package:ifgf_apps/data/models/image_response.dart';

class IcareResponse {
  String? id;
  String? jenisIcare;
  String? dateTime;
  String? location;
  List<ImageResponse?>? thumbnail;
  List<ImageResponse?>? poster;

  IcareResponse({
    required this.id,
    required this.jenisIcare,
    required this.dateTime,
    required this.location,
    required this.thumbnail,
    required this.poster,
  });

  factory IcareResponse.fromMap(Map<String, dynamic> map) {
    return IcareResponse(
      id: map['id'] as String,
      jenisIcare: map['jenis_icare'] as String,
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
      'jenis_icare': jenisIcare,
      'date_time': dateTime,
      'location': location,
      'thumbnail': thumbnail?.map((e) => e?.toMap()).toList(),
      'poster': poster?.map((e) => e?.toMap()).toList(),
    };
  }
}
