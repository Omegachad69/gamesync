import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/features/matches/domain/repos/match_repo.dart';

class UploadWinner implements UseCase<String, UploadWinnerparams> {
  final MatchRepository matchRepository;
  UploadWinner(this.matchRepository);

  @override
  Future<Either<Failure, String>> call(UploadWinnerparams parameters) async {
    return await matchRepository.uploadWinner(
        mid: parameters.mid, winner: parameters.winner);
  }
}

class UploadWinnerparams {
  final String mid;
  final String winner;

  UploadWinnerparams({required this.mid, required this.winner});
}
