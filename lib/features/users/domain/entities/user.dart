import 'dart:io';

class UserEntity {
  final int ? userId;
  final String ? username;
  final String ? password;
  final String ? name;
  final String ? email;
  final String ? imagePath;
  final File ? imageFile;

  UserEntity({
    this.userId,
    this.username,
    this.password,
    this.name,
    this.email,
    this.imagePath,
    this.imageFile,
  });
}

