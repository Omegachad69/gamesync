import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/domain/repos/tour_repo.dart';

class GetAllTours implements UseCase<List<Tour>, NoParams> {
  final TourRepository tourRepository;

  GetAllTours(this.tourRepository);

  @override
  Future<Either<Failure, List<Tour>>> call(NoParams params) async {
    return await tourRepository.getAllTours();
  }
}
