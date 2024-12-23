part of 'match_bloc.dart';

@immutable
sealed class MatchEvent {}

final class MatchUploadToCloud extends MatchEvent {
  final String p1;
  final String p2;
  final int rno;
  final String tid;

  MatchUploadToCloud({
    required this.p1,
    required this.p2,
    required this.rno,
    required this.tid,
  });
}

final class MatchFetch extends MatchEvent {
  final String tid;
  final int rno;

  MatchFetch({required this.tid, required this.rno});
}

final class MatchWinnerUpload extends MatchEvent {
  final String mid;
  final String winner;

  MatchWinnerUpload({required this.mid, required this.winner});
}

final class MatchUserMatchFetch extends MatchEvent {
  final String pid;

  MatchUserMatchFetch({required this.pid});
}
