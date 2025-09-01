import 'package:firebase_auth/firebase_auth.dart';

class SignUpResponse {
  final UserCredential userCredential;

  SignUpResponse({
    required this.userCredential,
  });
}