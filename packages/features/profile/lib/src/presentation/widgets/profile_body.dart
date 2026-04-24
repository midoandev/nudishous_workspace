import 'package:core_logic/core_logic.dart';
import 'package:core_ui/core_ui.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:core_i18n/core_i18n.dart';
import 'package:profile/src/presentation/widgets/profile_menu_tile.dart';
class ProfileBody extends StatelessWidget {
  final UserEntity? user;
  final VoidCallback onAuthAction;
  final VoidCallback onSettingAction;

  const ProfileBody({
    super.key,
    this.user,
    required this.onSettingAction,
    required this.onAuthAction,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.s.profile;
    final isAuthenticated = user != null;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER SECTION ---
          _buildHeader(context, isAuthenticated, s, colorScheme, textTheme),

          const SizedBox(height: 32),

          // --- ACCOUNT SECTION ---
          _buildSectionTitle(context, s.section_account.toUpperCase()),
          _buildMenuCard(
            context,
            children: [
              ProfileMenuTile(
                icon: FeatherIcons.user,
                title: s.personal_info,
                onTap: onSettingAction, // Ganti ke Edit Profile Route jika ada
              ),
              ProfileMenuTile(
                icon: FeatherIcons.settings,
                title: context.s.settings.title,
                onTap: onSettingAction,
              ),
              ProfileMenuTile(
                icon: FeatherIcons.helpCircle,
                title: s.faq,
                onTap: () {}, // Navigate to FAQ
              ),
            ],
          ),

          const SizedBox(height: 24),

          // --- ACTION SECTION ---
          _buildMenuCard(
            context,
            children: [
              ProfileMenuTile(
                icon: isAuthenticated ? FeatherIcons.logOut : FeatherIcons.logIn,
                title: isAuthenticated ? s.logout : s.login,
                isDestructive: isAuthenticated,
                onTap: onAuthAction,
              ),
            ],
          ),

          // --- FOOTER ---
          const SizedBox(height: 40),
          Center(
            child: Text(
              '${s.version} ${AppInfo.fullVersion}',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isAuth, dynamic s, ColorScheme color, TextTheme text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          BuildAvatar(
            // Gunakan ukuran yang lebih besar untuk header
            name: isAuth ? user!.firstName ?? '' : s.guest_name,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAuth ? user!.firstName ?? '' : s.guest_name,
                  style: text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  isAuth ? user!.email ?? '' : s.guest_subtitle,
                  style: text.bodyMedium?.copyWith(color: color.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title,
        style: context.textTheme.labelLarge?.copyWith(
          color: context.colorScheme.primary,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }
}