import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/chart/view_models/chart_viewmodel.dart';

class ChartScreen extends StatelessWidget {
  final ChartViewModel chartViewModel;

  const ChartScreen({super.key, required this.chartViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Chart'),
      ),
    );
  }
}
