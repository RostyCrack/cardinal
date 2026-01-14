import 'package:cardinal/core/failure/failure.dart';

class QrFailure extends Failure{
  const QrFailure(super.message);

  @override
  List<Object?> get props => [message];
}


