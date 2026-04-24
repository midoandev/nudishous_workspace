import 'package:core_ui/core_ui.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:core_i18n/core_i18n.dart';

import '../../../auth.dart';

class LoginView extends HookWidget {
  final VoidCallback onSwitchToRegister;
  final VoidCallback loginWithGoogle;

  const LoginView({
    super.key,
    required this.onSwitchToRegister,
    required this.loginWithGoogle,
  });

  @override
  Widget build(BuildContext context) {
    final L = context.s.auth;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPasswordVisible = useState(false);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthUpdated>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: L.form_email,
                                hintText: L.form_email_hint,
                                prefixIcon: const Icon(FeatherIcons.mail),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return L.auth_email_empty;
                                }
                                if (!value.contains('@')) {
                                  return L.auth_email_invalid;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: passwordController,
                              obscureText: !isPasswordVisible.value,
                              decoration: InputDecoration(
                                labelText: L.auth_password,
                                hintText: L.auth_password_hint,
                                prefixIcon: const Icon(FeatherIcons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible.value
                                        ? FeatherIcons.eyeOff
                                        : FeatherIcons.eye,
                                  ),
                                  onPressed: () => isPasswordVisible.value =
                                      !isPasswordVisible.value,
                                ),
                              ),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return L.auth_password_empty;
                                }
                                if (value.length < 6) {
                                  return L.auth_password_length;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '${L.auth_forgot_password}?',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colorScheme.primary,
                            foregroundColor: context.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            L.auth_login,
                            style: const TextStyle(letterSpacing: 1.2),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// OR divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: context.colorScheme.outline.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(L.auth_or),
                          ),
                          Expanded(
                            child: Divider(
                              color: context.colorScheme.outline.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// Google Login
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: AppAssets.vectors.googleIcon.svg(
                            height: 20,
                            width: 20,
                          ),
                          onPressed: () {},
                          label: Text(L.auth_continue_with_google),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(
                              color: context.colorScheme.outline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: onSwitchToRegister,
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodyMedium,
                      children: [
                        TextSpan(text: "${L.auth_no_account} "),
                        TextSpan(
                          text: L.auth_register_now,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
