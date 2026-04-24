import 'package:auto_route/auto_route.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/profile_cubit.dart';
import '../cubits/profile_state.dart';
import '../widgets/profile_body.dart';

@RoutePage()
class ProfilePage extends StatelessWidget implements AutoRouteWrapper {
  const ProfilePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..checkAndLoad(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileUpdated>(
          builder: (context, state) {
            return switch (state) {
              ProfileLoading() => const AppLoadingScreen(),
              ProfileLoaded(user: final user) => ProfileBody(
                user: user,
                onSettingAction:() => context.navigateToPath(NavConstants.settings),
                onAuthAction: () => context.read<ProfileCubit>().logout(),
              ),
              ProfileGuest() => ProfileBody(
                onSettingAction:() => context.navigateToPath(NavConstants.settings),
                onAuthAction:() async{
                  await context.navigateToPath(NavConstants.auth);
                  if (context.mounted) {
                    await context.read<ProfileCubit>().onLoginSuccess();
                  }
                }
              ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
