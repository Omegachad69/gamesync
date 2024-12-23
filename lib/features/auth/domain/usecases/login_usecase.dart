import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/common/entities/user.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/features/auth/domain/repository/auth_repository.dart';
import 'package:gameync/features/auth/domain/usecases/current_user_usecase.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams parameters) async {
    return await authRepository.loginWithEmailPassword(
        email: parameters.email, password: parameters.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}

class UserLogOut implements UseCase<dynamic, NoParams> {
  final AuthRepository authRepository;
  UserLogOut(this.authRepository);

  @override
  Future<Either<Failure, dynamic>> call(NoParams parameters) async {
    return await authRepository.logOutUser();
  }
}
