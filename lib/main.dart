import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/widgets/auth_gate.dart';
import 'firebase_options.dart';
import 'injections.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initInjections();
  final service = FlutterBackgroundService();

  runApp(CardinalApp());
}

class CardinalApp extends StatelessWidget {
  const CardinalApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>(),
        ),
        // Si luego necesitas más cubits, los agregas aquí
      ],
      child: MaterialApp(
        title: 'Cardinal App',
        home: const AuthGate(),
      ),
    );
  }
}
