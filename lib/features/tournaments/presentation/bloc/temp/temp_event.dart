part of 'temp_bloc.dart';

@immutable
sealed class TempEvent {}

final class TempUserTourFetch extends TempEvent {
  final String pid;

  TempUserTourFetch({required this.pid});
}
