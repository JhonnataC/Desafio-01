import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/core/widgets/form.dart';

class ShowFormDialog extends StatelessWidget {
  final String? editValue;
  final Function(String) onSubmit;

  const ShowFormDialog({
    super.key,
    this.editValue,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ),
        Positioned(
          bottom: bottomInset,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: CustomForm(
              title: editValue == null
                  ? 'O grupo poderia se chamar...'
                  : 'Edite o nome do grupo',
              editValue: editValue,
              onSubmit: onSubmit,
            ),
          ),
        ),
      ],
    );
  }
}
