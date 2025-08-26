import 'package:dartz/dartz.dart';
import '../failure/failure.dart';

/// Standard interface for all use cases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}