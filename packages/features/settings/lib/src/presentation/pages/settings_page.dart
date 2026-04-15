import 'package:flutter/material.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';

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
      appBar: AppBar(
        title: Text(s.settings.title),
      ),
      body: ListView(
        children: [
          // SEKSI BAHASA
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(s.settings.language),
            subtitle: Text(s.sandbox.language_name), // Menampilkan bahasa yang aktif
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguagePicker(context),
          ),
          const Divider(),

          // SEKSI TEMA (Placeholder untuk project selanjutnya)
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: Text(s.settings.dark_mode),
            value: context.theme.brightness == Brightness.dark,
            onChanged: (value) {
              // TODO: Implementasi ThemeCubit nanti
            },
          ),

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
                title: const Text("English"),
                onTap: () {
                  context.read<LocaleCubit>().setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Indonesia"),
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
}