part of 'currentuser_cubit.dart';

@immutable
sealed class CurrentuserState {}

final class CurrentuserInitial extends CurrentuserState {}

final class CurrentUserLoggedIn extends CurrentuserState {
  final User user;

  CurrentUserLoggedIn(this.user);
}

final class CurrenUserEmpty extends CurrentuserState {}
