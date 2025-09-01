class UserModel {
  late String uid;
  late String name;
  late String email;
  String? image;
  bool? emailVerified;
  UserModel({
    required this.name,
    required this.email,
    this.image,
    required this.emailVerified,
    required this.uid,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? "";
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    image = json['image'];
    emailVerified = json['emailVerified'] ?? false;
  }

  // UserModel.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   email = json['email'];
  //   image = json['image'];
  //   emailVerified = json['emailVerified'] ?? false;
  //   uid = json['uid'];
  // }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'emailVerified': emailVerified,
      "uid": uid,
    };
  }
}
