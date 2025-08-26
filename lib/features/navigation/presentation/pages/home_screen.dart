import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/helper/app_navigator.dart';
import '../../../emergency/pages/emergency.dart';
import '../../../fuec/pages/fuec.dart';
import '../../../map/presentation/pages/map.dart';
import '../../../operation/pages/operacion.dart';
import '../widgets/option_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Opciones del menú
  List<HomeOption> get _options => const [
    HomeOption(title: "Operación", icon: LucideIcons.briefcase),
    HomeOption(title: "FUEC", icon: LucideIcons.fileText),
    HomeOption(title: "Mapa", icon: LucideIcons.map),
    HomeOption(title: "Emergencia", icon: LucideIcons.alertTriangle, isDanger: true),
  ];

  void _onOptionSelected(BuildContext context, HomeOption option) {
    switch (option.title) {
      case "Operación":
        AppNavigator.push(context, const OperationScreen());
        break;
      case "FUEC":
        AppNavigator.push(context, const FuecScreen());
        break;
      case "Mapa":
        AppNavigator.push(context, const MapScreen());
        break;
      case "Emergencia":
        AppNavigator.push(context, const EmergencyScreen());
        break;
      default:
        debugPrint("Opción no implementada: ${option.title}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú Principal"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: _options.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columnas
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final option = _options[index];
            return OptionCard(
              option: option,
              onTap: () => _onOptionSelected(context, option),
            );
          },
        ),
      ),
    );
  }
}