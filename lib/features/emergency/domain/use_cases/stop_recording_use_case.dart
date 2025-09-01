import 'package:cardinal/core/use_case/use_case.dart';
import 'package:cardinal/features/emergency/data/repositories/audio_repository.dart';
import 'package:cardinal/features/emergency/domain/entities/recording.dart';
import 'package:dartz/dartz.dart';
import '../exceptions/exceptions.dart';

class StopRecordingUseCase extends UseCase<Recording, NoParams, AudioFailure> {
  final AudioRepository audioRepository;

  StopRecordingUseCase(this.audioRepository);

  @override
  Future<Either<AudioFailure, Recording>> call(NoParams params) async {
    return await audioRepository.stopRecording();
  }
}