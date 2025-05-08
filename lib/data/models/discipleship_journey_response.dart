import 'package:ifgf_apps/data/models/image_response.dart';

class DiscipleshipJourneyResponse {
  String? id;
  String? jenisDiscipleshipJourney;
  String? dateTime;
  String? location;
  List<ImageResponse?>? thumbnail;
  List<ImageResponse?>? poster;

  DiscipleshipJourneyResponse({
    this.id,
    this.jenisDiscipleshipJourney,
    this.dateTime,
    this.location,
    this.thumbnail,
    this.poster,
  });

  factory DiscipleshipJourneyResponse.fromMap(Map<String, dynamic> map) {
    return DiscipleshipJourneyResponse(
      id: map['id'] as String,
      jenisDiscipleshipJourney: map['jenis_discipleship_journey'] as String,
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
      'jenis_discipleship_journey': jenisDiscipleshipJourney,
      'date_time': dateTime,
      'location': location,
      'thumbnail': thumbnail?.map((e) => e?.toMap()).toList(),
      'poster': poster?.map((e) => e?.toMap()).toList(),
    };
  }
}
