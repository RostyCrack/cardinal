sealed class EmergencyState {
  const EmergencyState();

  const factory EmergencyState.initial() = _Initial;
  const factory EmergencyState.recording() = _Recording;
  const factory EmergencyState.success(String filePath) = _Success;
  const factory EmergencyState.failure(String message) = _Failure;
  const factory EmergencyState.loading() = _Loading;
  const factory EmergencyState.uploading() = _Uploading;
  const factory EmergencyState.uploadSuccess() = _UploadSuccess;

  T when<T>({
    required T Function() initial,
    required T Function() recording,
    required T Function(String filePath) success,
    required T Function(String message) failure,
    required T Function() loading,
    required T Function() uploading,
    required T Function() uploadSuccess,
  }) => switch (this) {
    _Initial() => initial(),
    _Recording() => recording(),
    _Success(:final filePath) => success(filePath),
    _Failure(:final message) => failure(message),
    _Loading() => loading(),
    _Uploading() => uploading(),
    _UploadSuccess() => uploadSuccess(),
  };

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? recording,
    T Function(String filePath)? success,
    T Function(String message)? failure,
    T Function()? loading,
    T Function()? uploading,
    T Function()? uploadSuccess,
    required T Function() orElse,
  }) => switch (this) {
    _Initial() => initial?.call() ?? orElse(),
    _Recording() => recording?.call() ?? orElse(),
    _Success(:final filePath) => success?.call(filePath) ?? orElse(),
    _Failure(:final message) => failure?.call(message) ?? orElse(),
    _Loading() => loading?.call() ?? orElse(),
    _Uploading() => uploading?.call() ?? orElse(),
    _UploadSuccess() => uploadSuccess?.call() ?? orElse(),
  };
}

final class _Initial extends EmergencyState {
  const _Initial();
}

final class _Recording extends EmergencyState {
  const _Recording();
}

final class _Success extends EmergencyState {
  final String filePath;
  const _Success(this.filePath);
}

final class _Failure extends EmergencyState {
  final String message;
  const _Failure(this.message);
}

final class _Loading extends EmergencyState {
  const _Loading();
}

final class _Uploading extends EmergencyState {
  const _Uploading();
}

final class _UploadSuccess extends EmergencyState {
  const _UploadSuccess();
}