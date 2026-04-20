import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../settings.dart';

@RoutePage()
class SettingsPage extends StatelessWidget implements AutoRouteWrapper {
  const SettingsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => SettingsCubit(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    // Kita gunakan extension context.s yang kita buat tadi
    final s = context.s;

    return Scaffold(
      appBar: AppBar(title: Text(s.settings.title)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: Text(context.s.settings.theme),
            // misal: "App Theme"
            subtitle: Text(
              context.watch<ThemeCubit>().state == ThemeMode.dark
                  ? context.s.settings.theme_dark
                  : context.s.settings.theme_light,
            ),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () => _showThemePicker(context),
          ),
          ListTile(
            leading: const Icon(Icons.translate_outlined),
            title: Text(context.s.settings.language),
            subtitle: Text(
              context.watch<LocaleCubit>().state.languageCode == 'id'
                  ? context
                        .s
                        .settings
                        .indonesia // "Indonesia"
                  : context.s.settings.english, // "English"
            ),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () => _showLanguagePicker(context),
          ),

          const Divider(),
          // SEKSI INFO
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(s.settings.about),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: s.app.title,
                applicationVersion: '1.0.0',
              );
            },
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.s.settings.select_language,
                  style: context.textTheme.titleMedium,
                ),
              ),
              ListTile(
                title: Text(context.s.settings.english),
                trailing: context.watch<LocaleCubit>().state == Locale('en')
                    ? Icon(Icons.check, color: context.colorScheme.primary)
                    : null,
                onTap: () {
                  context.read<LocaleCubit>().setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(context.s.settings.indonesia),
                trailing: context.watch<LocaleCubit>().state == Locale('id')
                    ? Icon(Icons.check, color: context.colorScheme.primary)
                    : null,
                onTap: () {
                  context.read<LocaleCubit>().setLocale(const Locale('id'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showThemePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.s.settings.select_theme, // Menggunakan i18n
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.light_mode_outlined),
                title: Text(context.s.settings.theme_light),
                trailing: context.watch<ThemeCubit>().state == ThemeMode.light
                    ? Icon(Icons.check, color: context.colorScheme.primary)
                    : null,
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: Text(context.s.settings.theme_dark),
                trailing: context.watch<ThemeCubit>().state == ThemeMode.dark
                    ? Icon(Icons.check, color: context.colorScheme.primary)
                    : null,
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
