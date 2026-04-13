import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../cubits/profile_cubit.dart';
import '../cubits/profile_state.dart';
import '../widgets/profile_authenticated_view.dart';
import '../widgets/profile_guest_view.dart';

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
      body: BlocBuilder<ProfileCubit, ProfileUpdated>(
        builder: (context, state) {
          return switch (state) {
            ProfileGuest()   => const ProfileGuestView(),  // ← tidak perlu AuthCubit!
            ProfileLoading() => const AppLoadingScreen(),
            ProfileLoaded()  => ProfileAuthenticatedView(user: state.user),
            // ProfileError()   => ProfileErrorView(message: state.message),
            _                => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}