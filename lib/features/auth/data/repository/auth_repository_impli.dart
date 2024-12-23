import 'package:fpdart/fpdart.dart';

import 'package:gameync/core/common/entities/user.dart';
import 'package:gameync/core/error/exception.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:gameync/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpli implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpli(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String uname,
      required String name,
      required String phoneNumber,
      required String email,
      required String password}) async {
    return _getUser(() async => await remoteDataSource.signUpWIthEmailPassword(
        uname: uname,
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password));
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await remoteDataSource.loginWithEmailPassword(
          email: email, password: password);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User Not Logged In'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> logOutUser() async {
    try {
      final logout = await remoteDataSource.logOutUser();

      return right(logout);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
