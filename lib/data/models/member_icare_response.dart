class MemberIcareResponse {
  String? id;
  String? fullName;
  String? jenisIcare;
  String? age;
  String? phoneNumber;
  String? birthDate;
  String? createdAt;

  MemberIcareResponse({
    this.id,
    this.fullName,
    this.jenisIcare,
    this.phoneNumber,
    this.birthDate,
    this.age,
    this.createdAt,
  });

  factory MemberIcareResponse.fromMap(Map<String, dynamic> map) {
    return MemberIcareResponse(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? '',
      jenisIcare: map['jenis_icare'] ?? '',
      phoneNumber: map['phone'] ?? '',
      birthDate: map['birth_date'] ?? '',
      age: map['age'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'jenis_icare': jenisIcare,
      'phone': phoneNumber,
      'birth_date': birthDate,
      'age': age,
      'created_at': createdAt,
    };
  }
}
