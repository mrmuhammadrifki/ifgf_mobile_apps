class NatsResponse {
   String? id;
   String? ayat;
   String? isi;
   String? tanggal;
   String? createdAt;

  NatsResponse({
    required this.id,
    required this.ayat,
    required this.isi,
    required this.tanggal,
    required this.createdAt,
  });

  factory NatsResponse.fromMap(Map<String, dynamic> map) {
    return NatsResponse(
      id: map['id'] as String,
      ayat: map['ayat'] as String,
      isi: map['isi'] as String,
      tanggal: map['tanggal'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ayat': ayat,
      'isi': isi,
      'tanggal': tanggal,
      'created_at': createdAt,
    };
  }
}
