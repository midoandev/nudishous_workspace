import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../core_ui.dart';

class BuildAvatar extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final Uint8List? avatarUint; // base64 string
  final double size;

  const BuildAvatar({
    super.key,
    required this.name,
    this.avatarUint,
    this.avatarUrl,
    this.size = 38.0,
  });

  @override
  Widget build(BuildContext context) {
    final initials = (name.trim().isNotEmpty)
        ? name.trim().split(' ').map((e) => e[0]).take(2).join().toUpperCase()
        : '?';

    if (avatarUint == null && avatarUrl != null) {
      return SizedBox(
        height: size,
        width: size,
        child: CircleAvatar(
          backgroundColor: context.theme.colorScheme.secondaryFixed,
          backgroundImage: NetworkImage(avatarUrl!),
          child: null,
        ),
      );
    }

    return SizedBox(
      height: size,
      width: size,
      child: CircleAvatar(
        backgroundColor: context.colorScheme.secondaryFixed,
        backgroundImage: (avatarUint != null) ? MemoryImage(avatarUint!) : null,
        child: (avatarUint == null)
            ? Text(
                initials,
                style: TextStyle(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              )
            : null,
      ),
    );
  }
}
