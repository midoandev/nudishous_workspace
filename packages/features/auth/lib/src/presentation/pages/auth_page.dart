import 'package:auth/src/presentation/cubits/auth_cubit.dart';
import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthPage extends StatelessWidget implements AutoRouteWrapper {
  const AuthPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => AuthCubit(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
