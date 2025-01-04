import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const CustomFloatingActionButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        LucideIcons.listPlus,
        color: theme.colorScheme.onPrimary,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
        backgroundColor: theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      label: Text(
        label,
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}
