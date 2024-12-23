import 'package:gameync/features/tournaments/domain/entities/particioant.dart';

class ParticpantModel extends Participant {
  ParticpantModel(
      {required super.uid,
      required super.uname,
      required super.name,
      required super.phoneNumber,
      required super.email});

  factory ParticpantModel.fromJson(Map<String, dynamic> map) {
    return ParticpantModel(
        uid: map['uid'] ?? '',
        uname: map['uname'] ?? '',
        name: map['name'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        email: map['email'] ?? '');
  }

  ParticpantModel copyWith({
    String? uid,
    String? uname,
    String? name,
    String? phoneNumber,
    String? email,
  }) {
    return ParticpantModel(
      uid: uid ?? this.uid,
      uname: uname ?? this.uname,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }
}
