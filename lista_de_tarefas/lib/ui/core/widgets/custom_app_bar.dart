import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  AppBar build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: theme.primary,
      surfaceTintColor: theme.primary,
      title: Image.asset(
        'assets/imgs/logo.png',
        width: 90,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 8),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              LucideIcons.filter,
              color: theme.onPrimary,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
