import 'dart:io';

import 'package:fpdart/src/either.dart';

import 'package:uuid/uuid.dart';

import 'package:gameync/core/error/exception.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/features/tournaments/data/data_sources/tour_remote_data_source.dart';
import 'package:gameync/features/tournaments/data/models/tour_model.dart';
import 'package:gameync/features/tournaments/domain/entities/particioant.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/domain/repos/tour_repo.dart';

class TourRepoImpli implements TourRepository {
  final TourRemoteDataSource tourRemoteDataSource;

  TourRepoImpli(this.tourRemoteDataSource);

  @override
  Future<Either<Failure, Tour>> uploadTour(
      {required tname,
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
      required String game}) async {
    try {
      TourModel tourModel = TourModel(
          tname: tname,
          tid: const Uuid().v1(),
          adminId: adminId,
          descp: descp,
          rules: rules,
          dateTime: dateTime,
          imageUrl: '',
          isPaid: isPaid,
          ispvp: ispvp,
          isduel: isduel,
          maxPartcipants: maxPartcipants,
          maxTeam: maxTeam,
          pricepool: pricepool,
          isprivate: isprivate,
          inviteLink: inviteLink,
          noWinners: noWinners,
          cPart: cPart,
          entryfee: entryfee,
          game: game);

      final imageUrl = await tourRemoteDataSource.uploadTourImage(
          image: image, tour: tourModel);
      tourModel = tourModel.copyWith(imageUrl: imageUrl);
      final uploadedTour = await tourRemoteDataSource.uploadTour(tourModel);
      return right(uploadedTour);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Tour>>> getAllTours() async {
    try {
      final tours = await tourRemoteDataSource.getAllTours();
      return right(tours);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> participateOnTour(
      {required String tid, required String uid, required int cPart}) async {
    try {
      final joinedPart = await tourRemoteDataSource.particpateOnTour(
          uid: uid, tid: tid, cPart: cPart);
      return right(joinedPart);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Participant>>> getAllParticipants(
      {required String tid}) async {
    try {
      final partici = await tourRemoteDataSource.getAllParticipants(tid: tid);
      return right(partici);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserJoined(
      {required String uid, required String tid}) async {
    try {
      final isJoined =
          await tourRemoteDataSource.isUserJoined(uid: uid, tid: tid);

      return right(isJoined);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> leaveParticipant(
      {required String uid, required String tid, required int cPart}) async {
    try {
      final leavePart = await tourRemoteDataSource.leaveParticipant(
          tid: tid, uid: uid, cPart: cPart);
      return right(leavePart);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Tour>>> getUserTours(
      {required String pid}) async {
    try {
      final userTours = await tourRemoteDataSource.getUserTours(pid: pid);
      return right(userTours);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteTour({required String tid}) async {
    try {
      final delete = await tourRemoteDataSource.deleteTour(tid: tid);
      return right(delete);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
