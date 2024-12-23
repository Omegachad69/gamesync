import 'package:gameync/core/common/entities/matches.dart';

class MatchModel extends Matches {
  MatchModel({
    required super.mid,
    required super.p1,
    required super.p2,
    required super.tid,
    required super.rno,
    super.p1name,
    super.p2name,
    super.winner,
    super.tname,
  });

  MatchModel copyWith({
    String? mid,
    String? p1,
    String? p2,
    int? rno,
    String? tid,
    String? p1name,
    String? p2name,
    String? winner,
    String? tname,
  }) {
    return MatchModel(
      mid: mid ?? this.mid,
      p1: p1 ?? this.p1,
      p2: p2 ?? this.p2,
      rno: rno ?? this.rno,
      tid: tid ?? this.tid,
      p1name: p1name ?? this.p1name,
      p2name: p2name ?? this.p2name,
      winner: winner ?? this.winner,
      tname: tname ?? this.tname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mid': mid,
      'p1': p1,
      'p2': p2,
      'rno': rno,
      'tid': tid,
    };
  }

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      mid: map['mid'] ?? '',
      p1: map['p1'] ?? '',
      p2: map['p2'] ?? '',
      rno: map['rno'] ?? '',
      tid: map['tid'] ?? '',
    );
  }
}
