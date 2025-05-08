class LoginResponse {
  String? name;
  String? email;
  String? photoUrl;

  LoginResponse({
    this.name,
    this.email,
    this.photoUrl,
  });

  LoginResponse.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    email = map['email'];
    photoUrl = map['photoUrl'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
