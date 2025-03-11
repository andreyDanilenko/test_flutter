class Profile {
  final String name;
  final String email;
  final String phone;
  final List<String> avatars;

  Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatars,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      avatars: List<String>.from(json['avatars']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'avatars': avatars,
    };
  }
}
