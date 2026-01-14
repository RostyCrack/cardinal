import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/network_constants.dart';

part 'qr_remote_data_source.g.dart';

@RestApi(baseUrl: SATELITAL_BASE_URL)
abstract class QrRemoteDataSource {
  factory QrRemoteDataSource(Dio dio) = _QrRemoteDataSource;

  @POST(LECTOR_QR)
  Future<HttpResponse<bool>> sendQrInfo({
    @Header('Authorization') required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });
}
