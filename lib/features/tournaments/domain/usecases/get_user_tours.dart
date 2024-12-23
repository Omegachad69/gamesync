import 'package:fpdart/src/either.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/domain/repos/tour_repo.dart';

class GetUserTours implements UseCase<List<Tour>, GetUserTourParams> {
  final TourRepository tourRepository;
  GetUserTours(this.tourRepository);

  @override
  Future<Either<Failure, List<Tour>>> call(GetUserTourParams parameters) async {
    return await tourRepository.getUserTours(pid: parameters.pid);
  }
}

class GetUserTourParams {
  final String pid;
  GetUserTourParams(this.pid);
}
