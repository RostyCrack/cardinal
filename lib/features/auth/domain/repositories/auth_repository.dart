import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();

  Future<Either<Failure, UserEntity>> signIn(String email, String password);


}