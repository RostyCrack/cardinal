import 'package:cardinal/features/auth/domain/use_cases/listen_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injections.dart';
import '../../../navigation/presentation/widgets/nav_bar.dart';
import '../../domain/use_cases/login.dart';
import '../../domain/use_cases/logout.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../pages/login_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkAuthState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Unauthenticated) {
          return const LoginPage();
        }
        if (state is Authenticated) {
          return const CustomBottomNavigation();
        }
        if (state is AuthError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}


class AuthGateProvider extends StatelessWidget {
  const AuthGateProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: const AuthGate(),
    );
  }
}