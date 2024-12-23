import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/error/exception.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/features/matches/data/data_sources/match_remote_data_source.dart';
import 'package:gameync/features/matches/data/models/match_model.dart';

import 'package:gameync/core/common/entities/matches.dart';
import 'package:gameync/features/matches/domain/repos/match_repo.dart';
import 'package:uuid/uuid.dart';

class MatchRepositoryImpli implements MatchRepository {
  final MatchRemoteDataSource matchRemoteDataSource;

  MatchRepositoryImpli(this.matchRemoteDataSource);

  @override
  Future<Either<Failure, Matches>> uploadMatch(
      {required String p1,
      required String p2,
      required int rno,
      required String tid}) async {
    try {
      MatchModel matchModel = MatchModel(
        mid: const Uuid().v4(),
        p1: p1,
        p2: p2,
        rno: rno,
        tid: tid,
      );
      final uploadedMatches =
          await matchRemoteDataSource.uploadMatches(matchModel);
      return right(uploadedMatches);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Matches>>> getAllMatches(
      {required String tid, required int rno}) async {
    try {
      final matches =
          await matchRemoteDataSource.getAllMatches(tid: tid, rno: rno);
      return right(matches);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> uploadWinner(
      {required String mid, required String winner}) async {
    try {
      final winners =
          await matchRemoteDataSource.uploadWinner(mid: mid, winner: winner);
      return right(winners);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Matches>>> getUserMatches(
      {required String pid}) async {
    try {
      final matchesu = await matchRemoteDataSource.getUserMatches(pid: pid);
      return right(matchesu);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
