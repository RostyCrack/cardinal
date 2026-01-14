import 'package:dartz/dartz.dart';
import '../exceptions/qr_exceptions.dart';

abstract class QrRepository {
  Future<Either<QrFailure, bool>> sendDocument(String document);
}