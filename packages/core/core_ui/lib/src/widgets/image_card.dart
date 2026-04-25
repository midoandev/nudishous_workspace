import 'package:flutter/material.dart';

import '../../core_ui.dart';

class ImageCard extends StatelessWidget {
  final String url;
  final double? size;
  const ImageCard({super.key, required this.url, this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: size ?? 40,
        height: size ?? 40,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          width: size ?? 40,
          height: size ?? 40,
          color: context.colorScheme.surfaceContainerHighest,
          child: Icon(
            Icons.fastfood_outlined,
            color: context.colorScheme.onSurface.withValues(
              alpha: .5,
            ),
          ),
        ),
      ),
    );
  }
}
