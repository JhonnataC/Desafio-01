import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Check extends StatelessWidget {
  const Check({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(LucideIcons.check, color: theme.onSecondary),
    );
  }
}
