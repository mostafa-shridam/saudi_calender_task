import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({
    this.name,
    this.email,
    this.uId,
    this.image,
  });
  String? name;
  String? email;
  String? uId;
  String? image;

  factory UserModel.fromFirebaseUser(User? user) {
    return UserModel(
      name: user?.displayName ?? '',
      email: user?.email ?? '',
      uId: user?.uid ?? "",
      image: user?.photoURL ??
          "https://w7.pngwing.com/pngs/27/394/png-transparent-computer-icons-user-user-heroes-black-avatar-thumbnail.png",
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uId: json['uId'],
      image: json['image'],
    );
  }

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'image': image,
    };
  }
}
