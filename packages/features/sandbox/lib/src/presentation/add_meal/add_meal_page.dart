// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/src/presentation/add_meal/widgets/build_meal_type_selector.dart';
import 'package:sandbox/src/presentation/add_meal/widgets/meal_type_selector.dart';

import '../../router/sandbox_router.gr.dart';
import 'cubits/add_meal_cubit.dart';
import 'cubits/add_meal_state.dart';
import 'widgets/plate_list.dart';

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
    final cubit = context.read<AddMealCubit>();

    return BlocBuilder<AddMealCubit, AddMealState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(s.title), centerTitle: true),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Search Trigger (Pasif)
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () async {
                    // Navigasi ke SearchPage dan tunggu hasilnya
                    final food = await context.router.push<FoodEntity>(
                      const SearchRoute(),
                    );
                    if (food != null) {
                      cubit.addToPlate(food);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.colorScheme.outlineVariant,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FeatherIcons.search,
                          size: 18,
                          color: context.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          s.searchPlaceholder,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MealTypeSelector(selectedType: state.selectedMealType, onSelected: (newSelection) {
                context.read<AddMealCubit>().changeMealType(
                  newSelection,
                );
              },),
              Expanded(
                child: state.plateItems.isEmpty
                    ? _buildEmptyState(context, s)
                    : PlateList(
                        plateItems: state.plateItems,
                        removeItem: (item) => cubit.removeFromPlate(item),
                        onSubmit: (val, item) {
                          final weight = double.tryParse(val) ?? 0;
                          cubit.updateWeight(item, weight);
                        },
                      ),
              ),

              // 3. Bottom Summary & Action
              if (state.plateItems.isNotEmpty)
                _buildBottomAction(context, state, cubit),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, dynamic s) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.set_meal_outlined,
            size: 48,
            color: context.colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            context.s.sandbox.addMeal.emptyPlate,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(
    BuildContext context,
    AddMealState state,
    AddMealCubit cubit,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, context.mq.padding.bottom + 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.s.sandbox.addMeal.totalSummary,
                style: context.textTheme.titleSmall,
              ),
              Text(
                "${state.totalCalories.toInt()} kcal",
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                await cubit.saveAllMeals();
                if (context.mounted) context.router.pop();
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(context.s.sandbox.search.add_to_diary),
            ),
          ),
        ],
      ),
    );
  }
}
