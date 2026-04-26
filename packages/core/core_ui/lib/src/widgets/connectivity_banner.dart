import 'package:core_i18n/core_i18n.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ConnectivityBanner extends StatelessWidget {
  final bool isOffline;

  const ConnectivityBanner({super.key, required this.isOffline});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      height: isOffline ? 40 : 0,
      width: double.infinity,
      // Modern API: withValues
      color: isOffline
          ? context.colorScheme.error.withValues(alpha: 0.9)
          : Colors.green.withValues(alpha: 0.0),
      child: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 14,
                color: context.colorScheme.onError,
              ),
              const SizedBox(width: 8),
              Text(
                context.s.common.offline_mode,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onError,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}