part of 'participant_bloc.dart';

@immutable
sealed class ParticipantEvent {}

final class Participation extends ParticipantEvent {
  final String tid;
  final String uid;
  final int cPart;
  Participation({required this.tid, required this.uid, required this.cPart});
}

final class ParticipantFetch extends ParticipantEvent {
  final String tid;

  ParticipantFetch({required this.tid});
}

final class ParticipantIsUserJoined extends ParticipantEvent {
  final String tid;
  final String uid;

  ParticipantIsUserJoined({required this.tid, required this.uid});
}

final class ParticipentLeaveEvent extends ParticipantEvent {
  final String tid;
  final String uid;
  final int cPart;
  ParticipentLeaveEvent(
      {required this.tid, required this.uid, required this.cPart});
}
