class MemberDiscipleshipJourneyResponse {
  String? id;
  String? fullName;
  String? jenisDiscipleshipJourney;
  String? age;
  String? phoneNumber;
  String? birthDate;
  String? createdAt;

  MemberDiscipleshipJourneyResponse({
    this.id,
    this.fullName,
    this.jenisDiscipleshipJourney,
    this.phoneNumber,
    this.birthDate,
    this.age,
    this.createdAt,
  });

  factory MemberDiscipleshipJourneyResponse.fromMap(Map<String, dynamic> map) {
    return MemberDiscipleshipJourneyResponse(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? '',
      jenisDiscipleshipJourney: map['jenis_discipleship_journey'] ?? '',
      phoneNumber: map['phone'] ?? '',
      birthDate: map['birth_date'] ?? '',
      age: map['age'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'jenis_discipleship_journey': jenisDiscipleshipJourney,
      'phone': phoneNumber,
      'birth_date': birthDate,
      'age': age,
      'created_at': createdAt,
    };
  }
}
