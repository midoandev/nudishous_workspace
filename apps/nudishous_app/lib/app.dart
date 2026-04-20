import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<LocaleCubit>()),
        BlocProvider.value(value: getIt<ThemeCubit>()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    final locale = context.watch<LocaleCubit>().state;
    final theme = context.watch<ThemeCubit>().state;
    return MaterialApp.router(
      title: config.appTitle,
      debugShowCheckedModeBanner: config.flavor == Flavor.dev,
      themeMode: theme,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: getIt<AppRouter>().config(),
      locale: locale,
      supportedLocales: I18n.supportedLocales,
      localizationsDelegates: I18n.localizationsDelegates,
    );
  }
}
