import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth.dart';

class RegisterView extends StatefulWidget {
  final VoidCallback onSwitchToRegister;

  const RegisterView({super.key, required this.onSwitchToRegister});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthUpdated>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 24),

                if (state is AuthError)
                  Text(
                    state.message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),

                const SizedBox(height: 16),
                FilledButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () => context.read<AuthCubit>().login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                  child: state is AuthLoading
                      ? const CircularProgressIndicator()
                      : const Text('Daftar'),
                ),
                TextButton(
                  onPressed: widget.onSwitchToRegister,
                  child: const Text('Sudah punya akun? Masuk'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
