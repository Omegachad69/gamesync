import 'dart:io';

import 'package:fpdart/fpdart.dart';

import 'package:gameync/core/error/failure.dart';

import 'package:gameync/features/tournaments/domain/entities/particioant.dart';
import 'package:gameync/core/common/entities/tour.dart';

abstract interface class TourRepository {
  Future<Either<Failure, Tour>> uploadTour({
    required tname,
    required String adminId,
    required String descp,
    required String rules,
    required DateTime dateTime,
    required File image,
    required bool isPaid,
    required bool ispvp,
    required bool isduel,
    required int maxPartcipants,
    required int? maxTeam,
    required double? pricepool,
    required bool isprivate,
    required String? inviteLink,
    required int noWinners,
    required int cPart,
    required double? entryfee,
    required String game,
  });

  Future<Either<Failure, List<Tour>>> getAllTours();

  Future<Either<Failure, String>> participateOnTour(
      {required String tid, required String uid, required int cPart});

  Future<Either<Failure, List<Participant>>> getAllParticipants(
      {required String tid});
  Future<Either<Failure, bool>> isUserJoined(
      {required String uid, required String tid});

  Future<Either<Failure, String>> leaveParticipant(
      {required String uid, required String tid, required int cPart});

  Future<Either<Failure, List<Tour>>> getUserTours({required String pid});
  Future<Either<Failure, dynamic>> deleteTour({required String tid});
}
