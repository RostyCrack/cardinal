import 'package:dartz/dartz.dart';
import '../failure/failure.dart';

/// Standard interface for all use cases
abstract class UseCase<Type, Params, F extends Failure> {
  Future<Either<F, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParams {
  const NoParams();
}