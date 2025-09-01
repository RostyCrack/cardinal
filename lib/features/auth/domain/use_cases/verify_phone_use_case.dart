import 'package:cardinal/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/sign_up_requests.dart';
import '../exceptions/auth_exceptions.dart';
import '../repositories/auth_repository.dart';

class VerifyPhoneNumberUseCase
    extends UseCase<Unit, VerifyPhoneNumberRequest, AuthFailure> {
  final AuthRepository authRepository;

  VerifyPhoneNumberUseCase(this.authRepository);

  @override
  Future<Either<AuthFailure, Unit>> call(VerifyPhoneNumberRequest request) {
    return authRepository.verifyPhoneNumber(request);
  }
}