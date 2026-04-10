import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';

import '../cubits/profile_cubit.dart';

@RoutePage()
class ProfilePage extends StatelessWidget implements AutoRouteWrapper {
  const ProfilePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => ProfileCubit(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
