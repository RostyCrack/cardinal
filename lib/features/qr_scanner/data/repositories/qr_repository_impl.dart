import 'package:cardinal/features/qr_scanner/data/data_sources/qr_remote_data_source.dart';
import 'package:cardinal/features/qr_scanner/domain/exceptions/qr_exceptions.dart';
import 'package:cardinal/features/qr_scanner/domain/repositories/qr_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/helper/auth_manager.dart';

class QrRepositoryImpl implements QrRepository {
  final QrRemoteDataSource qrRemoteDataSource;
  final AuthManager _authManager;

  QrRepositoryImpl(this.qrRemoteDataSource, this._authManager);

  @override
  Future<Either<QrFailure, bool>> sendDocument(String document) async {
    try {
      final token = await _authManager.getValidToken(TokenType.ws);
      final response = await qrRemoteDataSource.sendQrInfo(
        bearerToken: 'Bearer $token',
        body: {"documento": document, "idPorteria": 2},
      );

      return Right(response.data);
    } catch (e) {
      return Left(QrFailure('Hubo un error enviando la informacion del QR.'));
    }
  }
}
