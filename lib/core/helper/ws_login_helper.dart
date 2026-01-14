import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../constants/network_constants.dart';
import 'get_token_ws_auth_response.dart';

part 'ws_login_helper.g.dart';

@RestApi(baseUrl: "")
abstract class WSLoginHelper {
  factory WSLoginHelper(Dio dio) = _WSLoginHelper;

  @POST(SATELITAL_LOGIN_URL)
  Future<HttpResponse<GetTokenWsAuthResponse>> login({
    @Body() required Map<String, dynamic> body,
  });
}