import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable{}

class SignUpInitial extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpCodeSent extends SignUpState {
  String verificationId;
  SignUpCodeSent({this.verificationId = ""});
  @override
  List<Object?> get props => [verificationId];
}

class SignUpPhoneVerified extends SignUpState {
  final dynamic user; // Reemplaza 'dynamic' con el tipo real de usuario si lo conoces

  SignUpPhoneVerified(this.user);
  @override
  List<Object?> get props => [user];
}

class SignUpSuccess extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpError extends SignUpState {
  final String message;

  SignUpError(this.message);

  @override
  List<Object?> get props => [message];
}

class SignUpVerifyingCode extends SignUpState {
  @override
  List<Object?> get props => [];
}
