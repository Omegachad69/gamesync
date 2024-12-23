import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/common/entities/user.dart';
import 'package:gameync/core/error/failure.dart';
import 'package:gameync/core/usecase/use_case.dart';
import 'package:gameync/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams parameters) async {
    return await authRepository.currentUser();
  }
}

class NoParams {}
