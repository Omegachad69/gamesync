part of 'match_bloc.dart';

@immutable
sealed class MatchState {}

final class MatchInitial extends MatchState {}

final class MatchLoading extends MatchState {}

final class MatchFailure extends MatchState {
  final String error;

  MatchFailure(this.error);
}

final class MatchSuccess extends MatchState {}

final class MatchDisplaySuccess extends MatchState {
  final List<Matches> matches;

  MatchDisplaySuccess(this.matches);
}

final class MatchWinnerSuccess extends MatchState {}

final class MatchUserDisplaySuccess extends MatchState {
  final List<Matches> matchesu;
  MatchUserDisplaySuccess(this.matchesu);
}
