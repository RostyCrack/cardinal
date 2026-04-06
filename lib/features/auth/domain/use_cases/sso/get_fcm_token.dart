import 'dart:developer';

import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class GetFcmToken {
  Future<Either<AuthFailure, String>> call() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      return Right(token ?? '');
    } catch (e, s) {
      log('GetFcmToken: failed to get FCM token (non-blocking): $e', stackTrace: s);
      return Right('');
    }
  }
}
