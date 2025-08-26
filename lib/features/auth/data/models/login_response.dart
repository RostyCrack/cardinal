import 'package:firebase_auth/firebase_auth.dart';

class LoginResponse {
  final UserCredential userCredential;

  const LoginResponse({required this.userCredential});
}