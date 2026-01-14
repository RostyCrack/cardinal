import 'dart:async';

import 'package:cardinal/features/qr_scanner/domain/exceptions/qr_exceptions.dart';
import 'package:cardinal/features/qr_scanner/domain/use_cases/send_document_use_case.dart';
import 'package:cardinal/features/qr_scanner/presentation/bloc/qr_reader_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrReaderCubit extends Cubit<QrReaderState> {
  final SendDocumentUseCase sendDocumentUseCase;

  QrReaderCubit({required this.sendDocumentUseCase})
    : super(QrReaderInitialState());

  Future<void> sendReadDocument(String document) async {
    emit(QrReaderLoadingState());

    try {
      sendDocumentUseCase.call(document).then((result) {
        result.fold(
          (failure) {
            emit(QrReaderFailureState(failure));
            return;
          },
          (result) async {
            emit(QrReaderSuccessState(result));
          },
        );
      });
    } catch (e) {
      emit(
        QrReaderFailureState(
          QrFailure("El QR no se ha leído correctamente."),
        ),
      );
    }
  }
}
