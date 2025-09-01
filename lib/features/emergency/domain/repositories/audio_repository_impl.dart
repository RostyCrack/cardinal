
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../data/repositories/audio_repository.dart';
import '../../domain/entities/recording.dart';
import '../exceptions/exceptions.dart';

class AudioRepositoryImpl implements AudioRepository {
  final _record = AudioRecorder();

  AudioRepositoryImpl();

  Future<String> _generateFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    final fileName = "emergency_${DateTime.now().millisecondsSinceEpoch}.m4a";
    return "${dir.path}/$fileName";
  }

  @override
  Future<Either<AudioFailure, Unit>> startRecording() async {
    log("AudioRepositoryImpl/startRecording: Starting recording");
    if (await _record.hasPermission()) {
      final path = await _generateFilePath();
      await _record.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc, // codec
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: path,
      );
        return Right(unit);
    } else {
      log("AudioRepositoryImpl/startRecording: No permission to record audio");
      return Left(NoPermissionException());
    }
  }

  @override
  Future<Either<AudioFailure, Recording>> stopRecording() async {
    log("AudioRepositoryImpl/stopRecording: Stopping recording");
    final path = await _record.stop();
    log("AudioRepositoryImpl/stopRecording: Recording stopped, file path: $path");
    if (path == null) {
      log("AudioRepositoryImpl/stopRecording: No active recording");
      return Left(NoActiveRecordingException());
    }

      return Right(Recording(filePath: path, timestamp: DateTime.now()));
    }

  @override
  Future<Either<AudioFailure, bool>> isRecording() async {
    try {
      final result = await _record.isRecording();
      log("AudioRepositoryImpl/isRecording: Audio is recording: $result");
      return Right(result);
    } catch (e) {
      return Left(UnableToGetIsAudioRecordingException());
    }
  }
}