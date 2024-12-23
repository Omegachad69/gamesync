part of 'tour_bloc.dart';

@immutable
sealed class TourEvent {}

final class TourUploadToCloud extends TourEvent {
  final String tname;

  final String adminId;
  final String descp;
  final String rules;
  final DateTime dateTime;
  final File image;
  final bool isPaid;
  final bool ispvp;
  final bool isduel;
  final int maxPartcipants;
  final int? maxTeam;
  final double? pricepool;
  final bool isprivate;
  final String? inviteLink;
  final int noWinners;
  final int cPart;
  final double? entryfee;
  final String game;

  TourUploadToCloud(
      {required this.tname,
      required this.adminId,
      required this.descp,
      required this.rules,
      required this.dateTime,
      required this.image,
      required this.isPaid,
      required this.ispvp,
      required this.isduel,
      required this.maxPartcipants,
      required this.maxTeam,
      required this.pricepool,
      required this.isprivate,
      required this.inviteLink,
      required this.noWinners,
      required this.cPart,
      required this.entryfee,
      required this.game});
}

final class TourFetchAllTours extends TourEvent {}

// final class TourParticipation extends TourEvent {
//   final String tid;
//   final String uid;
//   final int cPart;
//   TourParticipation(
//       {required this.tid, required this.uid, required this.cPart});
// }

// final class TourParticipantFetch extends TourEvent {
//   final String tid;

//   TourParticipantFetch({required this.tid});
// }

// final class TourIsUserJoined extends TourEvent {
//   final String tid;
//   final String uid;

//   TourIsUserJoined({required this.tid, required this.uid});
// }
