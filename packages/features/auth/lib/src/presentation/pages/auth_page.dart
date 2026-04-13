import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';

import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';
import '../widgets/login_view.dart';
import '../widgets/register_view.dart';

@RoutePage()
class AuthPage extends StatelessWidget implements AutoRouteWrapper {
  const AuthPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthUpdated>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // ✅ Setelah login → otomatis pop kembali ke Profile
          context.router.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Masuk'),
        ),
        body:
            LoginView(onSwitchToRegister: () {})
      ),
    );
  }

}

enum AuthMode { login, register }
