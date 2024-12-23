import 'package:gameync/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.uid,
    required super.uname,
    required super.name,
    required super.phoneNumber,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] ?? '',
        uname: map['uname'] ?? '',
        name: map['name'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        email: map['email'] ?? '');
  }

  UserModel copyWith({
    String? uid,
    String? uname,
    String? name,
    String? phoneNumber,
    String? email,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      uname: uname ?? this.uname,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }
}
