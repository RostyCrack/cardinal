import 'package:flutter/material.dart';

class AppNavigator {
  static void pushReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  static void pushAndRemoveUntil(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget),
            (route) => false); // Elimina todas las rutas previas
  }

  static void push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static Future<bool> pushReturn(BuildContext context, Widget widget) async {
    final response = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget));

    return response;
  }

  static void popReload(BuildContext context) {
    Navigator.pop(context, true);
  }
}
