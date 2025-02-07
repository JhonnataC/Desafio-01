import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/src/ui/widgets/custom_form.dart';

class ShowFormDialogHome extends StatelessWidget {
  final String? editValue;
  final double bottomDistance;
  final Function(String) onSubmit;

  const ShowFormDialogHome({
    super.key,
    this.editValue,
    required this.onSubmit,
    required this.bottomDistance,
  });

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
        Positioned(
          bottom: bottomDistance,
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
