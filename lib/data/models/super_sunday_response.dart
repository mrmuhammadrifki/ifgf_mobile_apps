import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:ifgf_apps/data/models/petugas.dart';

class SuperSundayResponse {
  String? id;
  String? jenisJadwal;
  String? dateTime;
  String? location;
  Petugas? petugas;
  List<ImageResponse?>? thumbnail;
  List<ImageResponse?>? poster;

  SuperSundayResponse({
    this.id,
    this.jenisJadwal,
    this.dateTime,
    this.location,
    this.thumbnail,
    this.petugas,
    this.poster,
  });

  factory SuperSundayResponse.fromMap(Map<String, dynamic> map) {
    return SuperSundayResponse(
      id: map['id'] as String?,
      jenisJadwal: map['jenis_jadwal'] as String?,
      dateTime: map['date_time'] as String?,
      location: map['location'] as String?,
      petugas: map['petugas'] != null
          ? Petugas.fromMap(map['petugas'] as Map<String, dynamic>)
          : null,
      thumbnail: (map['thumbnail'] as List<dynamic>?)
              ?.map((e) => e != null
                  ? ImageResponse.fromMap(e as Map<String, dynamic>)
                  : null)
              .toList() ??
          [],
      poster: (map['poster'] as List<dynamic>?)
              ?.map((e) => e != null
                  ? ImageResponse.fromMap(e as Map<String, dynamic>)
                  : null)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jenis_jadwal': jenisJadwal,
      'date_time': dateTime,
      'location': location,
      'petugas': petugas?.toMap(),
      'thumbnail': thumbnail?.map((e) => e?.toMap()).toList(),
      'poster': poster?.map((e) => e?.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'SuperSundayResponse(id: $id, jenisJadwal: $jenisJadwal, dateTime: $dateTime, location: $location, petugas: $petugas, thumbnail: $thumbnail, poster: $poster)';
  }
}
