import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/common/entities/user.dart';
import 'package:gameync/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String uname,
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();

  Future<Either<Failure, dynamic>> logOutUser();
}
