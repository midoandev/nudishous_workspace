import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/add_meal_cubit.dart';
import '../cubits/add_meal_state.dart';
import '../widgets/floating_summary.dart';
import '../widgets/plate_list.dart';
import '../widgets/search_list.dart';

@RoutePage()
class AddMealPage extends StatelessWidget implements AutoRouteWrapper {
  const AddMealPage({super.key});

  static const String namePath = '/add_meal';

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<AddMealCubit>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s.sandbox.addMeal;
    return BlocConsumer<AddMealCubit, AddMealState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(s.title)),
          body: Column(
            children: [
              // Search Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: s.searchPlaceholder,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSubmitted: (val) =>
                      context.read<AddMealCubit>().searchFood(val),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: !state.isLoading,
                  replacement: const AppLoadingScreen(),
                  child: Stack(
                    children: [
                      // Tampilkan Hasil Search jika ada, jika tidak tampilkan Piring
                      state.searchResults.isNotEmpty
                          ? SearchList(searchResults: state.searchResults)
                          : PlateList(plateItems: state.plateItems),

                      // Summary melayang jika piring tidak kosong
                      if (state.plateItems.isNotEmpty)
                        FloatingSummary(total: state.totalCalories),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
