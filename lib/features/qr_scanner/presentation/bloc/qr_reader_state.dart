import 'package:cardinal/features/qr_scanner/domain/exceptions/qr_exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class QrReaderState extends Equatable {
  @override
  List<Object> get props => [];
}

class QrReaderInitialState extends QrReaderState {}

class QrReaderLoadingState extends QrReaderState {}

class QrReaderSuccessState extends QrReaderState {
  final bool successState;
  QrReaderSuccessState(this.successState);
  @override
  List<Object> get props => [successState];
}

class QrReaderFailureState extends QrReaderState {
  final QrFailure error;
  QrReaderFailureState(this.error);
  @override
  List<Object> get props => [error];
}
