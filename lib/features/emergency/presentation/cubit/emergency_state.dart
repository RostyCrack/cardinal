import 'package:freezed_annotation/freezed_annotation.dart';
part 'emergency_state.freezed.dart';

@freezed
class EmergencyState with _$EmergencyState {
  const factory EmergencyState.initial() = _Initial;
  const factory EmergencyState.recording() = _Recording;
  const factory EmergencyState.success(String filePath) = _Success;
  const factory EmergencyState.failure(String message) = _Failure;
  const factory EmergencyState.loading() = _Loading;
  const factory EmergencyState.uploading() = _Uploading;
  const factory EmergencyState.uploadSuccess() = _UploadSuccess;
}