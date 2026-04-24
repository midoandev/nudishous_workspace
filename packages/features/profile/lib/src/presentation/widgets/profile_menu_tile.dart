import 'package:core_ui/core_ui.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? context.colorScheme.error
        : context.colorScheme.onSurface;

    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(color: color),
      ),
      trailing: const Icon(FeatherIcons.chevronRight, size: 18),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
