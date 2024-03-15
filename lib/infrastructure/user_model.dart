class UserModel {
  String id;
  String name;
  String email;
  //String? mobile;
  String? profile;
  String? location;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      // this.mobile,
       this.profile ,
       this.location
      });


 factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['uid'],
        name: json['name'],
        email: json['email'],
       //mobile: json['mobile'] ?? '',
       profile: json['profile'] ?? '',
       location: json['location'] ?? '',
       );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = id;
    data['name'] = name;
    data['email'] = email;
    //ata['mobile'] = mobile;
    data['profile'] = profile;
    data['locaton'] =location;

    return data;
  }
}
