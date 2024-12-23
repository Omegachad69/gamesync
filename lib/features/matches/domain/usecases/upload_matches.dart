import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/core/common/entities/matches.dart';
import 'package:gameync/features/matches/domain/repos/match_repo.dart';

class UploadMatches implements UseCase<Matches, UploadMatchesParams> {
  final MatchRepository matchRepository;
  UploadMatches(this.matchRepository);

  @override
  Future<Either<Failure, Matches>> call(UploadMatchesParams parameters) async {
    return await matchRepository.uploadMatch(
      p1: parameters.p1,
      p2: parameters.p2,
      rno: parameters.rno,
      tid: parameters.tid,
    );
  }
}

class UploadMatchesParams {
  final String p1;
  final String p2;
  final int rno;
  final String tid;

  UploadMatchesParams({
    required this.p1,
    required this.p2,
    required this.rno,
    required this.tid,
  });
}
