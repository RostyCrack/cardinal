import 'package:cardinal/features/auth/data/models/sign_up_request.dart';
import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:cardinal/features/auth/domain/use_cases/save_user_locally.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/use_case/use_case.dart';
import '../exceptions/auth_exceptions.dart';

class SignUpUseCase extends UseCase<Unit, SignUpRequest, AuthFailure> {
  final AuthRepository authRepository;
  final SaveUserLocallyUseCase saveUserLocally;
  SignUpUseCase({required this.authRepository, required this.saveUserLocally});

  @override
  Future<Either<AuthFailure, Unit>> call(params) async {
    var userResponse = await authRepository.signUp(params);
    return userResponse.fold(
      (failure) {
        return Left(failure);
      },
      (user) async {
        var saveResponse = await saveUserLocally(UserEntity.fromModel(user));
        return saveResponse.fold(
          (failure) {
            return Left(failure);
          },
          (unit) {
            return Right(unit);
          },
        );
      },
    );
  }

  // Implement the sign-up logic here
}
