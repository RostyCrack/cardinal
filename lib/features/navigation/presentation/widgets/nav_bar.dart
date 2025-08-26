import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../core/helper/app_navigator.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../bloc/navigation_cubit.dart';
import '../bloc/navigation_state.dart';
import 'navigation_body.dart';


class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});
  static const String routeName = "/customButtonNavigation";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: const _CustomBottomNavigationView(),
    );
  }
}

class _CustomBottomNavigationView extends StatelessWidget {
  const _CustomBottomNavigationView();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    double iconSize = screenWidth < 350 ? 22 : screenWidth < 450 ? 26 : 28;
    double fontSize = screenWidth < 350 ? 12 : screenWidth < 450 ? 14 : 16;
    double gap = screenWidth < 350 ? 2 : 4;
    EdgeInsets padding = screenWidth < 350
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 18)
        : const EdgeInsets.symmetric(horizontal: 20, vertical: 30);

    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, navState) {
          return NavigationBody(
            selectedIndex: navState.index,
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, navState) {
          return GNav(
            padding: padding,
            selectedIndex: navState.index,
            onTabChange: (index) {
              final navigationCubit = context.read<NavigationCubit>();
              switch (index) {
                case 0:
                  navigationCubit.navigateToHome();
                  break;
                case 1:
                  navigationCubit.navigateToNotifications();
                  break;
                case 2:
                  navigationCubit.navigateToSettings();
                  break;
                default:
                  AppNavigator.pushReplacement(context, const LoginPage());
              }
            },
            tabMargin: const EdgeInsets.symmetric(horizontal: 15),
            textStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold),
            iconSize: iconSize,
            gap: gap,
            tabs: const [
              GButton(icon: Icons.home, text: 'Inicio'),
              GButton(icon: Icons.notifications, text: 'Notificaciones'),
              GButton(icon: Icons.settings, text: 'Configuración'),
            ],
          );
        },
      ),
    );
  }
}