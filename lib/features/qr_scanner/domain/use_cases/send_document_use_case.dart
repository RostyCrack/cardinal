import 'package:dartz/dartz.dart';
import '../../../../core/use_case/use_case.dart';
import '../exceptions/qr_exceptions.dart';
import '../repositories/qr_repository.dart';

class SendDocumentUseCase extends UseCase<bool, String, QrFailure> {
  final QrRepository qrRepository;

  SendDocumentUseCase(this.qrRepository);

  @override
  Future<Either<QrFailure, bool>> call(String document) {
    return qrRepository.sendDocument(document);
  }
}
