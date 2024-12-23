import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/core/common/entities/matches.dart';
import 'package:gameync/features/matches/domain/repos/match_repo.dart';

class GetUserMatches implements UseCase<List<Matches>, GetUserMatchesParams> {
  MatchRepository matchRepository;
  GetUserMatches(this.matchRepository);
  @override
  Future<Either<Failure, List<Matches>>> call(
      GetUserMatchesParams parameters) async {
    return await matchRepository.getUserMatches(pid: parameters.pid);
  }
}

class GetUserMatchesParams {
  final String pid;

  GetUserMatchesParams({
    required this.pid,
  });
}
