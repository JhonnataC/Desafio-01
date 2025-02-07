import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowConfirmBoxDialogHome extends StatefulWidget {
  final String groupName;
  final void Function() onSubmit;
  const ShowConfirmBoxDialogHome({
    super.key,
    required this.onSubmit,
    required this.groupName,
  });

  @override
  State<ShowConfirmBoxDialogHome> createState() => _ShowConfirmBoxDialogHomeState();
}

class _ShowConfirmBoxDialogHomeState extends State<ShowConfirmBoxDialogHome> {
  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Grupo excluído!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ),
        AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Tem certeza que quer excluir o grupo ${widget.groupName}?'),
          actions: [
            TextButton(
              onPressed: () {
                widget.onSubmit();
                context.pop();
                _showSnackBar();
              },
              child: Text(
                'Sim',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                'Não',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
