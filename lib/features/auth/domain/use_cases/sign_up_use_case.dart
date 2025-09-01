import 'package:cardinal/features/auth/data/models/sign_up_requests.dart';
import 'package:cardinal/features/auth/data/models/sign_up_response.dart';
import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:cardinal/features/auth/domain/use_cases/save_user_locally.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/use_case/use_case.dart';
import '../../data/models/user_model.dart';
import '../exceptions/auth_exceptions.dart';

class SignUpUseCase extends UseCase<SignUpResponse, SignUpRequest, AuthFailure> {
  final AuthRepository authRepository;

  SignUpUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<AuthFailure, SignUpResponse>> call(SignUpRequest params) async {
    final userResponse = await authRepository.signUp(params);

    return userResponse.fold(
          (failure) => Left(failure),
          (signUpResponse)=> Right(signUpResponse));
  }
}