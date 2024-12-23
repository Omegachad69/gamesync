import 'package:fpdart/fpdart.dart';
import 'package:gameync/core/error/failure.dart';

abstract interface class UseCase<SuccessType, Parameters> {
  Future<Either<Failure, SuccessType>> call(Parameters parameters);
}
