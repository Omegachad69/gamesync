import 'package:fpdart/src/either.dart';

import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/features/tournaments/domain/entities/particioant.dart';
import 'package:gameync/features/tournaments/domain/repos/tour_repo.dart';

class ParticipateOnTours implements UseCase<String, PartcipateTourParams> {
  final TourRepository tourRepository;

  ParticipateOnTours(this.tourRepository);

  @override
  Future<Either<Failure, String>> call(PartcipateTourParams parameters) async {
    return await tourRepository.participateOnTour(
        tid: parameters.tid, uid: parameters.uid, cPart: parameters.cPart);
  }
}

class PartcipateTourParams {
  final String tid;
  final String uid;
  final int cPart;
  PartcipateTourParams(
      {required this.tid, required this.uid, required this.cPart});
}

class ParticiPants implements UseCase<List<Participant>, ParticpantParms> {
  final TourRepository tourRepository;

  ParticiPants(this.tourRepository);
  @override
  Future<Either<Failure, List<Participant>>> call(
      ParticpantParms parameters) async {
    return await tourRepository.getAllParticipants(tid: parameters.tid);
  }
}

class ParticpantParms {
  final String tid;
  ParticpantParms({
    required this.tid,
  });
}

class IsUserJoined implements UseCase<bool, IsJoinedParams> {
  final TourRepository tourRepository;

  IsUserJoined(this.tourRepository);
  @override
  Future<Either<Failure, bool>> call(IsJoinedParams parameters) async {
    return await tourRepository.isUserJoined(
        uid: parameters.uid, tid: parameters.tid);
  }
}

class IsJoinedParams {
  final String uid;
  final String tid;

  IsJoinedParams({required this.uid, required this.tid});
}

class LeaveParticipant implements UseCase<String, LeaveParams> {
  final TourRepository tourRepository;
  LeaveParticipant(this.tourRepository);

  @override
  Future<Either<Failure, String>> call(LeaveParams parameters) async {
    return await tourRepository.leaveParticipant(
        uid: parameters.uid, tid: parameters.tid, cPart: parameters.cPart);
  }
}

class LeaveParams {
  final String uid;
  final String tid;
  final int cPart;
  LeaveParams({required this.uid, required this.tid, required this.cPart});
}
