import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/entities/matches.dart';
import 'package:gameync/features/matches/domain/usecases/get_all_matches.dart';
import 'package:gameync/features/matches/domain/usecases/get_user_matches.dart';
import 'package:gameync/features/matches/domain/usecases/upload_matches.dart';
import 'package:gameync/features/matches/domain/usecases/upload_winner.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final UploadMatches _uploadMatches;
  final GetAllMatches _getAllMatches;
  final UploadWinner _uploadWinner;
  final GetUserMatches _getUserMatches;
  MatchBloc(
      {required UploadMatches uploadMatches,
      required GetAllMatches getAllMatches,
      required UploadWinner uploadWinner,
      required GetUserMatches getUserMatches})
      : _uploadMatches = uploadMatches,
        _getAllMatches = getAllMatches,
        _uploadWinner = uploadWinner,
        _getUserMatches = getUserMatches,
        super(MatchInitial()) {
    on<MatchEvent>((event, emit) => emit(MatchLoading()));
    on<MatchUploadToCloud>(_onMatchUploadToCloud);
    on<MatchFetch>(_onMatchFetch);
    on<MatchWinnerUpload>(_onMatchWinnerUpload);
    on<MatchUserMatchFetch>(_onMatchUserMatchFetch);
  }

  void _onMatchUploadToCloud(
      MatchUploadToCloud event, Emitter<MatchState> emit) async {
    final res = await _uploadMatches(UploadMatchesParams(
        p1: event.p1, p2: event.p2, rno: event.rno, tid: event.tid));
    res.fold((l) => emit(MatchFailure(l.message)), (r) => emit(MatchSuccess()));
  }

  void _onMatchFetch(MatchFetch event, Emitter<MatchState> emit) async {
    final res = await _getAllMatches(
        GetAllMatchesParams(tid: event.tid, rno: event.rno));
    res.fold((l) => emit(MatchFailure(l.message)),
        (r) => emit(MatchDisplaySuccess(r)));
  }

  void _onMatchWinnerUpload(
      MatchWinnerUpload event, Emitter<MatchState> emit) async {
    final res = await _uploadWinner(
        UploadWinnerparams(mid: event.mid, winner: event.winner));
    res.fold((l) => emit(MatchFailure(l.message)),
        (r) => emit(MatchWinnerSuccess()));
  }

  void _onMatchUserMatchFetch(
      MatchUserMatchFetch event, Emitter<MatchState> emit) async {
    final res = await _getUserMatches(GetUserMatchesParams(pid: event.pid));
    res.fold((l) => emit(MatchFailure(l.message)),
        (r) => emit(MatchUserDisplaySuccess(r)));
  }
}
