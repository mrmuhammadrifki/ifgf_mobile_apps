class Petugas {
  String? preacher;
  String? singer;
  String? keyboard;
  String? bas;
  String? gitar;
  String? drum;
  String? multimedia;
  String? dokumentasi;
  String? lcdOperator;
  String? lighting;

  Petugas({
    this.preacher,
    this.singer,
    this.keyboard,
    this.bas,
    this.gitar,
    this.drum,
    this.multimedia,
    this.dokumentasi,
    this.lcdOperator,
    this.lighting,
  });

  Map<String, dynamic> toJson() {
    return {
      'preacher': preacher,
      'singer': singer,
      'keyboard': keyboard,
      'bas': bas,
      'gitar': gitar,
      'drum': drum,
      'multimedia': multimedia,
      'dokumentasi': dokumentasi,
      'lcd_operator': lcdOperator,
      'lighting': lighting,
    };
  }

  factory Petugas.fromMap(Map<String, dynamic> map) {
    return Petugas(
      preacher: map['preacher'] as String?,
      singer: map['singer'] as String?,
      keyboard: map['keyboard'] as String?,
      bas: map['bas'] as String?,
      gitar: map['gitar'] as String?,
      drum: map['drum'] as String?,
      multimedia: map['multimedia'] as String?,
      dokumentasi: map['dokumentasi'] as String?,
      lcdOperator: map['lcd_operator'] as String?,
      lighting: map['lighting'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'preacher': preacher,
      'singer': singer,
      'keyboard': keyboard,
      'bas': bas,
      'gitar': gitar,
      'drum': drum,
      'multimedia': multimedia,
      'dokumentasi': dokumentasi,
      'lcd_operator': lcdOperator,
      'lighting': lighting,
    };
  }

  @override
  String toString() {
    return 'Petugas(preacher: $preacher, singer: $singer, keyboard: $keyboard, bas: $bas, gitar: $gitar, drum: $drum, multimedia: $multimedia, dokumentasi: $dokumentasi, lcdOperator: $lcdOperator, lighting: $lighting)';
  }
}
