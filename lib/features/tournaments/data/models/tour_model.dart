import 'package:flutter/material.dart';
import 'package:gameync/core/common/entities/tour.dart';

class TourModel extends Tour {
  TourModel(
      {required super.tname,
      required super.tid,
      required super.adminId,
      required super.descp,
      required super.rules,
      required super.dateTime,
      required super.imageUrl,
      required super.isPaid,
      required super.ispvp,
      required super.isduel,
      required super.maxPartcipants,
      required super.maxTeam,
      required super.pricepool,
      required super.isprivate,
      required super.inviteLink,
      required super.noWinners,
      required super.entryfee,
      required super.cPart,
      super.aname,
      required super.game});
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tname': tname,
      'tid': tid,
      'adminId': adminId,
      'descp': descp,
      'rules': rules,
      'dateTime': dateTime.toIso8601String(),
      'imageUrl': imageUrl,
      'isPaid': isPaid,
      'ispvp': ispvp,
      'isduel': isduel,
      'maxPartcipants': maxPartcipants,
      'maxTeam': maxTeam,
      'pricepool': pricepool,
      'isprivate': isprivate,
      'inviteLink': inviteLink,
      'noWinners': noWinners,
      'entryfee': entryfee,
      'cPart': cPart,
      'game': game,
    };
  }

  factory TourModel.fromMap(Map<String, dynamic> map) {
    return TourModel(
      tname: map['tname'] as String,
      tid: map['tid'] as String,
      adminId: map['adminId'] as String,
      descp: map['descp'] as String,
      rules: map['rules'] as String,
      dateTime: map['dateTime'] == null
          ? DateTime.now()
          : DateTime.parse(map['dateTime']),
      imageUrl: map['imageUrl'] as String,
      isPaid: map['isPaid'] ?? false,
      ispvp: map['ispvp'] ?? false,
      isduel: map['isduel'] ?? true,
      maxPartcipants: map['maxPartcipants'] as int,
      maxTeam: map['maxTeam'] as int,
      pricepool: map['pricepool']?.toDouble(),
      isprivate: map['isprivate'] ?? false,
      inviteLink: map['inviteLink'] as String,
      noWinners: map['noWinners']?.toInt() ?? 1,
      cPart: map['cPart']?.toInt() ?? 0,
      entryfee: map['entryfee']?.toDouble(),
      game: map['game'] as String,
    );
  }

  TourModel copyWith({
    String? tname,
    String? tid,
    String? adminId,
    String? descp,
    String? rules,
    DateTime? dateTime,
    String? imageUrl,
    bool? isPaid,
    bool? ispvp,
    bool? isduel,
    int? maxPartcipants,
    int? maxTeam,
    ValueGetter<double?>? pricepool,
    bool? isprivate,
    ValueGetter<String?>? inviteLink,
    int? noWinners,
    ValueGetter<double?>? entryfee,
    int? cPart,
    String? game,
    String? aname,
  }) {
    return TourModel(
      tname: tname ?? this.tname,
      tid: tid ?? this.tid,
      adminId: adminId ?? this.adminId,
      descp: descp ?? this.descp,
      rules: rules ?? this.rules,
      dateTime: dateTime ?? this.dateTime,
      imageUrl: imageUrl ?? this.imageUrl,
      isPaid: isPaid ?? this.isPaid,
      ispvp: ispvp ?? this.ispvp,
      isduel: isduel ?? this.isduel,
      maxPartcipants: maxPartcipants ?? this.maxPartcipants,
      maxTeam: maxTeam ?? this.maxTeam,
      pricepool: pricepool != null ? pricepool() : this.pricepool,
      isprivate: isprivate ?? this.isprivate,
      inviteLink: inviteLink != null ? inviteLink() : this.inviteLink,
      noWinners: noWinners ?? this.noWinners,
      entryfee: entryfee != null ? entryfee() : this.entryfee,
      cPart: cPart ?? this.cPart,
      game: game ?? this.game,
      aname: aname ?? this.aname,
    );
  }
}
