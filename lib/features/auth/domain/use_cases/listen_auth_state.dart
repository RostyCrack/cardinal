import '../../../../core/use_case/use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class ListenAuthStateUseCase extends StreamUseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  ListenAuthStateUseCase(this.repository);

  @override
  Stream<UserEntity?> call(NoParams params) {
    return repository.authStateChanges();
  }
}