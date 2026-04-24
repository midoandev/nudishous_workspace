import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../auth.dart';


class RegisterView extends HookWidget {
  final VoidCallback onSwitchToRegister;

  const RegisterView({super.key, required this.onSwitchToRegister});
  @override
  Widget build(BuildContext context) {
    final L = context.s.auth;

    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final isPasswordVisible = useState(false);
    final isConfirmPasswordVisible = useState(false);

    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthUpdated>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Nama Lengkap
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: L.form_full_name,
                    hintText: L.form_full_name_hint,
                    prefixIcon: const Icon(FeatherIcons.user),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return L.form_full_name_empty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: L.form_email,
                    hintText: L.form_email_hint,
                    prefixIcon: const Icon(FeatherIcons.mail),
                  ),
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
                const SizedBox(height: 20),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible.value,
                  decoration: InputDecoration(
                    labelText: L.auth_password,
                    hintText: L.form_create_password,
                    prefixIcon: const Icon(FeatherIcons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible.value
                            ? FeatherIcons.eyeOff
                            : FeatherIcons.eye,
                      ),
                      onPressed: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !isConfirmPasswordVisible.value,
                  decoration: InputDecoration(
                    labelText: L.form_confirm_password,
                    hintText: L.form_confirm_password_hint,
                    prefixIcon: const Icon(FeatherIcons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible.value
                            ? FeatherIcons.eyeOff
                            : FeatherIcons.eye,
                      ),
                      onPressed: () {
                        isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return L.form_confirm_password_empty;
                    }
                    if (value != passwordController.text) {
                      return L.form_password_not_match;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Tombol DAFTAR
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      L.button_register, // "DAFTAR"
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodyMedium,
                      children: [
                        TextSpan(text: "${L.auth_already_have_account} "),
                        TextSpan(
                          text: L.auth_login,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => onSwitchToRegister(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
