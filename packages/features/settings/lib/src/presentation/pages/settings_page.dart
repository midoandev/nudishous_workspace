import 'package:auto_route/auto_route.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:feather_icons/feather_icons.dart';
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
    final themeMode = context.watch<ThemeCubit>().state;
    final currentLocale = context.watch<LocaleCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text(s.settings.title)),
      body: ListView(
        children: [
          buildSectionHeader(s.settings.section_preferences),
          ListTile(
            key: const Key('settings_theme_tile'),
            leading: const Icon(FeatherIcons.sun),
            title: Text(s.settings.theme),
            subtitle: Text(
              themeMode == ThemeMode.dark
                  ? s.settings.theme_dark
                  : s.settings.theme_light,
            ),
            trailing: const Icon(FeatherIcons.chevronRight, size: 20),
            onTap: () => _showThemePicker(context),
          ),
          ListTile(
            key: const Key('settings_language_tile'),
            leading: const Icon(Icons.translate_outlined),
            title: Text(s.settings.language),
            subtitle: Text(
              currentLocale.languageCode == 'id'
                  ? s.settings.indonesia
                  : s.settings.english,
            ),
            trailing: const Icon(FeatherIcons.chevronRight, size: 20),
            onTap: () => _showLanguagePicker(context),
          ),

          const Divider(),
          // --- SECTION: SECURITY (Berdasarkan folder fiturmu) ---
          buildSectionHeader(s.settings.security),
          ListTile(
            leading: const Icon(FeatherIcons.lock),
            title: Text(s.settings.change_password),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(FeatherIcons.smartphone),
            title: Text(s.settings.my_devices),
            onTap: () {},
          ),

          const Divider(),
          ListTile(
            leading: const Icon(FeatherIcons.helpCircle),
            title: Text(s.profile.faq),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(FeatherIcons.shield),
            title: Text(s.settings.privacy_policy),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(FeatherIcons.info),
            title: Text(s.settings.about),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: s.app.title,
              applicationVersion: '1.0.0',
            ),
          ),

          // SEKSI BAHAYA
          ListTile(
            leading: const Icon(FeatherIcons.userX, color: Colors.red),
            title: Text(
              s.settings.delete_account,
              style: const TextStyle(color: Colors.red),
            ),
            // onTap: () => _confirmDeleteAccount(context, s),
          ),

          const SizedBox(height: 20),
          Center(
            child: Text(
              "${s.profile.version} ${AppInfo.fullVersion}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 20),
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
                trailing:
                    context.watch<LocaleCubit>().state == const Locale('en')
                    ? Icon(Icons.check, color: context.colorScheme.primary)
                    : null,
                onTap: () {
                  context.read<LocaleCubit>().setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(context.s.settings.indonesia),
                trailing:
                    context.watch<LocaleCubit>().state == const Locale('id')
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

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
