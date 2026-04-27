import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/src/presentation/meals/widgets/build_date_group.dart';

import 'cubits/meals_cubit.dart';
import 'cubits/meals_state.dart';

@RoutePage()
class MealsPage extends StatelessWidget implements AutoRouteWrapper {
  const MealsPage({super.key});

  static const String namePath = '/meals';

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<MealsCubit>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.s.meals.title), centerTitle: false),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          return switch (state) {
            MealsLoading() => const AppLoadingScreen(),
            MealsLoaded(groups: final listGroup, selectedDate: final _) =>
              ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: listGroup.length,
                itemBuilder: (context, index) {
                  final entry = listGroup[index];
                  final DateTime date = entry.key;

                  return BuildDateGroup(date: date, listData: entry.value);
                },
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
