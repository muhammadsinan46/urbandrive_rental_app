class UserModel {
  String id;
  String name;
  String email;
  String? mobile;
  String? profile;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
       this.mobile,
       this.profile 
      });


 factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['uid'],
        name: json['name'],
        email: json['email'],
       mobile: json['mobile'] ?? '',
       profile: json['profile'] ?? ''
       );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['profile'] = profile;

    return data;
  }
}
