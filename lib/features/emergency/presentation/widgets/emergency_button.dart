import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EmergencyButton extends StatefulWidget {
  final VoidCallback onConfirmed;

  const EmergencyButton({super.key, required this.onConfirmed});

  @override
  State<EmergencyButton> createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // tiempo de confirmación
    )..addListener(() {
      setState(() {}); // 🔑 fuerza a redibujar el widget en cada tick
    });
  }

  void _onLongPressStart(LongPressStartDetails details) {
    _controller.forward();
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    if (_controller.isCompleted) {
      widget.onConfirmed();
    }
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: _onLongPressStart,
      onLongPressEnd: _onLongPressEnd,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.5),
              blurRadius: 12,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animación de progreso
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: _controller.value,
                strokeWidth: 6,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Colors.black26,
              ),
            ),
            // Ícono de emergencia
            const Icon(
              LucideIcons.alertTriangle,
              size: 36,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}