import 'dart:io';
import 'package:k_eventy/features/users/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    int? userId,
    String? username,
    String? password,
    String? name,
    String? email,
    String? imagePath,
    File? imageFile,
    String? token,
  }) : super(
    userId: userId,
    username: username,
    password: password,
    name: name,
    email: email,
    imagePath: imagePath,
    imageFile: imageFile,
    token: token
  );
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'] as int?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      imagePath: json['profile_image'] as String?,
      imageFile: null, // Set imageFile to null when deserializing from JSON
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'profile_file': imageFile,
      'token': token
    };
  }

  factory UserModel.fromDomain(UserEntity userEntity) {
    return UserModel(
      userId: userEntity.userId,
      username: userEntity.username,
      password: userEntity.password,
      name: userEntity.name,
      email: userEntity.email,
      imagePath: userEntity.imagePath
    );
  }
}