import 'package:cardinal/core/failure/failure.dart';

class AuthFailure extends Failure{
  const AuthFailure(super.message);

  @override
  List<Object?> get props => [message];
}


