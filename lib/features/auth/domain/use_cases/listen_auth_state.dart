import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user_entity.dart';
import '../exceptions/auth_exceptions.dart';
import '../repositories/auth_repository.dart';

class ListenAuthStateUseCase extends UseCase<Stream<UserEntity?>, NoParams> {
  final AuthRepository repository;

  ListenAuthStateUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<UserEntity?>>> call(NoParams params) async {
    try {
      final stream = repository.authStateChanges();
      return Right(stream);
    } catch (e) {
      return Left(UnexpectedAuthFailure(e.toString()));
    }
  }
}