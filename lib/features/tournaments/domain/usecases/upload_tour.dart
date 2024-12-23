import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/domain/repos/tour_repo.dart';

class UploadTour implements UseCase<Tour, UploadTourParams> {
  final TourRepository tourRepository;

  UploadTour(this.tourRepository);

  @override
  Future<Either<Failure, Tour>> call(UploadTourParams parameters) async {
    return await tourRepository.uploadTour(
        tname: parameters.tname,
        adminId: parameters.adminId,
        descp: parameters.descp,
        rules: parameters.rules,
        dateTime: parameters.dateTime,
        image: parameters.image,
        isPaid: parameters.isPaid,
        ispvp: parameters.ispvp,
        isduel: parameters.isduel,
        maxPartcipants: parameters.maxPartcipants,
        maxTeam: parameters.maxPartcipants,
        pricepool: parameters.pricepool,
        isprivate: parameters.isprivate,
        inviteLink: parameters.inviteLink,
        noWinners: parameters.noWinners,
        cPart: parameters.cPart,
        entryfee: parameters.entryfee,
        game: parameters.game);
  }
}

class UploadTourParams {
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

  UploadTourParams(
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
