class UserModel {
  String id;
  String name;
  String email;
  String mobile;
  String profile;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.mobile,
      required this.profile});

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? profile,
  }) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        profile: profile ?? this.profile);
  }
}
