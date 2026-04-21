import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/src/domain/entities/meal_entry.dart';

import '../cubits/sandbox_cubit.dart';
import '../cubits/sandbox_state.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/energy_total_card.dart';
import '../widgets/header_section.dart';
import '../widgets/meal_list_section.dart';

@RoutePage()
class SandboxPage extends StatelessWidget implements AutoRouteWrapper {
  const SandboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SandboxCubit, SandboxUpdated>(
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderSection(),
                      const SizedBox(height: 24),
                      const EnergyTotalCard(totalKcal: 986),
                      const SizedBox(height: 32),

                      // LOGIKA EMPTY STATE
                      if (state.item.isEmpty)
                        const EmptyStateWidget()
                      else
                        MealListSection(entries: state.item),

                      const SizedBox(height: 100),
                      // Spacer agar tidak tertutup dock
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger tambah bahan dummy untuk tes reaktivitas
          context.read<SandboxCubit>().addItem(
            const MealEntry(
              id: '1',
              name: 'Ayam',
              calories: 165,
              protein: 31,
              carbs: 20,
              fat: 20,
              imageUrl: '',
              type: MealType.dinner,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => SandboxCubit(), child: this);
  }
}
