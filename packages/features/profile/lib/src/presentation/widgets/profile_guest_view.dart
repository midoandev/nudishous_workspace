import 'package:auto_route/auto_route.dart';
import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/profile_cubit.dart';

class ProfileGuestView extends StatelessWidget {
  const ProfileGuestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: () async {
                // Push ke AuthPage lalu tunggu hasilnya
                await context.navigateToPath(NavConstants.auth);

                // Setelah kembali → reload profile
                // Tidak perlu tahu apakah login sukses atau tidak
                // ProfileCubit yang akan cek token sendiri
                if (context.mounted) {
                  context.read<ProfileCubit>().onLoginSuccess();
                }
              },
              child: const Text('Masuk'),
            ),
          ],
        ),
      ),
    );
  }
}
