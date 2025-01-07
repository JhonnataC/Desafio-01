import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? action;
  const CustomAppBar({super.key, this.action});

  @override
  AppBar build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: theme.primary,
      surfaceTintColor: theme.primary,
      foregroundColor: theme.onPrimary,
      title: Image.asset(
        'assets/imgs/logo.png',
        width: 90,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 8),
          child: action,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
