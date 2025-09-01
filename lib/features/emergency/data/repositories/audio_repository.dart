import 'package:cardinal/features/emergency/domain/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/recording.dart';

abstract class AudioRepository {
  Future<Either<AudioFailure, Unit>> startRecording();
  Future<Either<AudioFailure, Recording>> stopRecording();
  Future<Either<AudioFailure, bool>>  isRecording();
}