import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/common/entities/matches.dart';

abstract interface class MatchRepository {
  Future<Either<Failure, Matches>> uploadMatch({
    required String p1,
    required String p2,
    required int rno,
    required String tid,
  });

  Future<Either<Failure, List<Matches>>> getAllMatches(
      {required String tid, required int rno});
  Future<Either<Failure, String>> uploadWinner(
      {required String mid, required String winner});
  Future<Either<Failure, List<Matches>>> getUserMatches({required String pid});
}
