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
    return BlocProvider(create: (_) => getIt<AuthCubit>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthUpdated>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // ✅ Setelah login → otomatis pop kembali ke Profile
          context.router.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state == AuthLoginInitial() ? 'Masuk' : 'Daftar'),
          ),
          body: switch (state) {
            AuthLoginInitial() => LoginView(
              onSwitchToRegister: () => context.read<AuthCubit>().changePage(),
            ),
            AuthRegisterInitial() => RegisterView(
              onSwitchToRegister: () => context.read<AuthCubit>().changePage(),
            ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

enum AuthMode { login, register }
