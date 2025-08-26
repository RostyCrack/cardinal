import 'dart:developer';
import 'package:flutter/material.dart';
import '../pages/home_screen.dart';
import '../pages/notification_screen.dart';
import '../pages/settings.dart';

class NavigationBody extends StatelessWidget {
  final int selectedIndex;

  const NavigationBody({
    required this.selectedIndex,
    super.key,
  });

  HomeScreen buildHomeScreen() {
    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0: // INICIO
        return buildHomeScreen();
      case 1: // NOTIFICACIONES
        log('NavigationNotification');
        return const NotificationScreen();
      case 2: // CONFIGURACIÓN
        log('Settings');
        return const SettingsScreen();
      default:
        return buildHomeScreen();
    }
  }
}