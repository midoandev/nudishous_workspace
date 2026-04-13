import 'package:flutter/material.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import '../cubits/sandbox_cubit.dart';
import '../cubits/sandbox_state.dart';

@RoutePage()
class SandboxPage extends StatelessWidget implements AutoRouteWrapper {
  const SandboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SandboxCubit, SandboxUpdated>(
        builder: (context, state) {
          return Column(
            children: [
              // Scoreboard Sederhana
              Container(
                padding: const EdgeInsets.all(20),
                color: AppColors.primaryLight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Kalori: ${state.totalCalories.toStringAsFixed(0)}'),
                    Text('Protein: ${state.totalProtein.toStringAsFixed(0)}g'),
                  ],
                ),
              ),
              const Expanded(
                child: Center(child: Text('Piring Digital Siap Diracik!')),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger tambah bahan dummy untuk tes reaktivitas
          context.read<SandboxCubit>().tambahBahan(
            const FoodItem(id: '1', name: 'Ayam', calories: 165, protein: 31),
          );
        },
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => SandboxCubit(), child: this);
  }
}
