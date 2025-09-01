import 'package:cardinal/core/failure/failure.dart';
import 'package:cardinal/core/use_case/use_case.dart';
import 'package:cardinal/features/emergency/data/repositories/audio_repository.dart';
import 'package:cardinal/features/emergency/domain/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';


class StartRecordingUseCase extends UseCase<Unit, NoParams, AudioFailure> {
  final AudioRepository audioRepository;

  StartRecordingUseCase(this.audioRepository);

  @override
  Future<Either<AudioFailure, Unit>> call(NoParams params) async {
    return await audioRepository.startRecording();
  }
}

