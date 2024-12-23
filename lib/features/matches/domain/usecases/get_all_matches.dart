import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/core/common/entities/matches.dart';
import 'package:gameync/features/matches/domain/repos/match_repo.dart';

class GetAllMatches implements UseCase<List<Matches>, GetAllMatchesParams> {
  MatchRepository matchRepository;
  GetAllMatches(this.matchRepository);
  @override
  Future<Either<Failure, List<Matches>>> call(
      GetAllMatchesParams parameters) async {
    return await matchRepository.getAllMatches(
        tid: parameters.tid, rno: parameters.rno);
  }
}

class GetAllMatchesParams {
  final String tid;
  final int rno;
  GetAllMatchesParams({
    required this.tid,
    required this.rno,
  });
}
