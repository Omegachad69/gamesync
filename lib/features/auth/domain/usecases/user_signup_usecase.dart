// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/common/entities/user.dart';

import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams parameters) async {
    return await authRepository.signUpWithEmailPassword(
        uname: parameters.uname,
        name: parameters.name,
        phoneNumber: parameters.phoneNumber,
        email: parameters.email,
        password: parameters.password);
  }
}

class UserSignUpParams {
  final String uname;
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  UserSignUpParams({
    required this.uname,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}
