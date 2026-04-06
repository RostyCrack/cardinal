import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SsoLoginState extends Equatable {
  const SsoLoginState();

  @override
  List<Object?> get props => [];
}

class SsoLoginInitial extends SsoLoginState {
  const SsoLoginInitial();
}

class SsoLoginLoading extends SsoLoginState {
  const SsoLoginLoading();
}

class SsoLoginSuccess extends SsoLoginState {
  final UserEntity user;
  const SsoLoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SsoLoginUserNotFound extends SsoLoginState {
  const SsoLoginUserNotFound();
}

class SsoLoginError extends SsoLoginState {
  final String message;
  const SsoLoginError(this.message);

  @override
  List<Object?> get props => [message];
}
