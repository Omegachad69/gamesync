part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String uname;
  final String name;
  final String phoneNumber;
  final String email;
  final String password;

  AuthSignUp(
      {required this.uname,
      required this.name,
      required this.phoneNumber,
      required this.email,
      required this.password});
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthUserLoggedOut extends AuthEvent {}
