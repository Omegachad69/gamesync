part of 'temp_bloc.dart';

@immutable
sealed class TempState {}

final class TempInitial extends TempState {}

final class TempFailure extends TempState {
  final String error;

  TempFailure(this.error);
}

final class TempLoading extends TempState {}

final class TempSuccess extends TempState {
  final List<Tour> usertours;

  TempSuccess(this.usertours);
}
