import 'package:cardinal/core/helper/ws_login_helper.dart';

enum TokenType { ws }

class AuthManager {
  final WSLoginHelper wsService;

  String? _tokenWS;
  DateTime? _tokenWSExpiry;

  AuthManager({
    required this.wsService,
  });

  Future<void> _login(TokenType type) async {
    if (type == TokenType.ws) {
      final response = await wsService.login(body: {
        'username': 'juanpinpin',
        'password': '123456',
      });
      _tokenWS = response.data.token;
      _tokenWSExpiry = DateTime.now().add(Duration(minutes: 30));
    }
  }

  Future<String> getValidToken(TokenType type) async {
    if (type == TokenType.ws) {
      if (_tokenWS == null || DateTime.now().isAfter(_tokenWSExpiry!)) {
        await _login(TokenType.ws);
      }
      return _tokenWS!;
    } else {
      return 'Invalid';
    }
  }
}