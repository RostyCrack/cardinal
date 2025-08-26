import 'package:flutter/material.dart';

class HomeOption {
  final String title;
  final IconData icon;
  final bool isDanger;

  const HomeOption({
    required this.title,
    required this.icon,
    this.isDanger = false,
  });
}

class OptionCard extends StatelessWidget {
  final HomeOption option;
  final VoidCallback? onTap; // 🔹 callback opcional

  const OptionCard({
    super.key,
    required this.option,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = option.isDanger ? Colors.red : Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onTap, // 🔹 aquí lo usas
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.8),
                color.withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(option.icon, size: 48, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  option.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}