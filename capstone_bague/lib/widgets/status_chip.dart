import 'package:flutter/material.dart';
import 'package:capstone_bague/models/item.dart';

class StatusChip extends StatelessWidget {
  final Item item;

  const StatusChip({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final String label;
    final Color background;
    final Color foreground;

    if (item.claimed) {
      label = 'CLAIMED';
      background = scheme.surfaceContainerHighest;
      foreground = scheme.onSurfaceVariant;
    } else if (item.type == ItemType.lost) {
      label = 'LOST';
      background = scheme.errorContainer;
      foreground = scheme.onErrorContainer;
    } else {
      label = 'FOUND';
      background = scheme.primaryContainer;
      foreground = scheme.onPrimaryContainer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}