import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injections.dart';
import '../cubit/emergency_cubit.dart';
import '../cubit/emergency_state.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRecording(BuildContext context, EmergencyState state) {
    final cubit = context.read<EmergencyCubit>();

    state.maybeWhen(
      recording: (){
        cubit.stopRecording();
        cubit.saveVehicleLocation();
      },
      orElse: () => cubit.startRecording(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmergencyCubit>(),
      child: Scaffold(
        backgroundColor: Colors.red.shade50,
        appBar: AppBar(
          title: const Text("Emergencia"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Center(
          child: ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.2).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
            ),
            child: BlocBuilder<EmergencyCubit, EmergencyState>(
              builder: (context, state) {
                final isRecording = state.maybeWhen(
                  recording: () => true,
                  orElse: () => false,
                );

                final micColor = isRecording ? Colors.red : Colors.green;

                return GestureDetector(
                  onTap: () => _toggleRecording(context, state),
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: micColor,
                      boxShadow: [
                        BoxShadow(
                          color: micColor.withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.mic,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}