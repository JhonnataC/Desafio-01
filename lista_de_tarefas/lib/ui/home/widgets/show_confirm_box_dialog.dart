import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowConfirmBoxDialog extends StatefulWidget {
  final String groupName;
  final void Function() onSubmit;
  const ShowConfirmBoxDialog({
    super.key,
    required this.onSubmit,
    required this.groupName,
  });

  @override
  State<ShowConfirmBoxDialog> createState() => _ShowConfirmBoxDialogState();
}

class _ShowConfirmBoxDialogState extends State<ShowConfirmBoxDialog> {
  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
