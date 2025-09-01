import 'package:cardinal/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';
import '../exceptions/account_exceptions.dart';

class SaveUserLocallyUseCase extends UseCase<Unit, UserEntity, UserFailure> {
  final UserRepository userRepository;

  SaveUserLocallyUseCase(this.userRepository);

  @override
  Future<Either<UserFailure, Unit>> call(UserEntity user) async {
    var userResponse = await userRepository.saveUser(user);
    userResponse.fold(
            (failure){
          return Left(failure);
        },
            (userSaved){
          return Right(unit);
       });
    return Left(UserFailure("Error al guardar el usuario"));
  }
}