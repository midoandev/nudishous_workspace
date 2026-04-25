import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sandbox/src/presentation/search/cubits/search_cubit.dart';
import 'package:sandbox/src/presentation/search/widgets/search_error_view.dart';

import 'cubits/search_state.dart';
import 'widgets/build_info_state.dart';
import 'widgets/build_result_list.dart';

@RoutePage()
class SearchPage extends HookWidget implements AutoRouteWrapper {
  const SearchPage({super.key});

  static const String namePath = '/search';

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<SearchCubit>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final searchText = useTextEditingController();
    final l = context.s.sandbox.search;
    final cubit = context.read<SearchCubit>();
    return Scaffold(
      // Kita hilangkan AppBar standar untuk kesan modern
      body: SafeArea(
        child: Column(
          children: [
            // 1. Custom Header Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
              child: Row(
                children: [
                  const BackButton(), // Tombol kembali yang clean
                  Expanded(
                    child: SearchBar(
                      controller: searchText,
                      hintText: l.search_hint,
                      autoFocus: true,
                      elevation: const WidgetStatePropertyAll(0),
                      backgroundColor: WidgetStatePropertyAll(
                        context.colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      onSubmitted: (value) => cubit.onSearchChanged(value),
                      trailing: [
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: context.colorScheme.primary,
                          ),
                          onPressed: () =>
                              cubit.onSearchChanged(searchText.text),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Content Area
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: switch (state) {
                      SearchInitial() => BuildInfoState(
                        icon: Icons.search_rounded,
                        label: l.search_initial_instruction,
                      ),
                      SearchLoading() => const Center(
                        child: AppLoadingScreen(),
                      ),
                      SearchLoaded(results: final list) => BuildResultList(
                        list: list,
                        onSelect: (FoodEntity food) {
                          context.router.pop(food);
                        },
                      ),
                      SearchEmpty(query: final q) => BuildInfoState(
                        icon: Icons.electric_moped,
                        label: l.search_empty(q),
                      ),
                      SearchError() => SearchMessageView(
                        icon: Icons.cloud_off_rounded,
                        title: context.s.sandbox.search.search_error, // i18n: "Connection Error"
                        onRetry: () => context.read<SearchCubit>().onSearchChanged(searchText.text),
                      ),
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
