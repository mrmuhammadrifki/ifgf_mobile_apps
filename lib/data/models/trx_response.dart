class TrxResponse {
  final String? id;
  final String? jenisTrx;
  final String? category;
  final String? createdAt;
  final num? nominal;
  final String? note;

  TrxResponse({
    this.id,
    this.jenisTrx,
    this.category,
    this.createdAt,
    this.nominal,
    this.note,
  });

  factory TrxResponse.fromMap(Map<String, dynamic> map) {
    return TrxResponse(
      id: map['id'] as String?,
      jenisTrx: map['jenis_trx'] as String?,
      category: map['kategori'] as String?,
      createdAt: map['created_at'] as String?,
      nominal: map['nominal'] as num?,
      note: map['catatan'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jenis_trx': jenisTrx,
      'kategori': category,
      'created_at': createdAt,
      'nominal': nominal,
      'catatan': note,
    };
  }

  @override
  String toString() {
    return 'TrxResponse(id: $id, jenisTrx: $jenisTrx, category: $category, createdAt: $createdAt, nominal: $nominal, note: $note)';
  }
}

class TrxListSummaryResponse {
  final List<TrxResponse> data;
  final String totalPemasukan;
  final String totalPengeluaran;
  final String totalSaldo;

  TrxListSummaryResponse({
    required this.data,
    required this.totalPemasukan,
    required this.totalPengeluaran,
    required this.totalSaldo,
  });
}
