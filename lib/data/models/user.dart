class User {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  final List<String> roles;
  final String cpf;
  final DateTime? birthDate;
  final String photoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.roles,
    required this.cpf,
    required this.birthDate,
    required this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      emailVerified: json["email_verified"] ?? false,
      roles: List<String>.from(json["roles"] ?? []),
      cpf: json["cpf"] ?? "",
      birthDate: json["birth_date"] != null
          ? DateTime.tryParse(json["birth_date"])
          : null,
      photoUrl: json["photo_url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "email_verified": emailVerified,
      "roles": roles,
      "cpf": cpf,
      "birth_date": birthDate?.toIso8601String(),
      "photo_url": photoUrl,  
    };
  }
}
