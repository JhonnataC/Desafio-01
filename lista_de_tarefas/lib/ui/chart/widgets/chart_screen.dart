import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/chart/view_models/chart_viewmodel.dart';
import 'package:lista_de_tarefas/ui/chart/widgets/custom_piechart.dart';
import 'package:lista_de_tarefas/ui/chart/widgets/list_tile_chart.dart';
import 'package:lista_de_tarefas/ui/chart/widgets/total_and_complete_tasks.dart';
import 'package:lista_de_tarefas/ui/core/widgets/custom_app_bar.dart';

class ChartScreen extends StatelessWidget {
  final ChartViewModel chartViewModel;

  const ChartScreen({super.key, required this.chartViewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = chartViewModel;

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: const CustomAppBar(),
      body: FutureBuilder(
        future: viewModel.loadTaskGroups(),
        builder: (context, snapshot) {
          final tasksInfo = viewModel.completedAndPendingTasks;
          final complete = tasksInfo['complete'] as double;
          final pending = tasksInfo['pending'] as double;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPieChart(
                completeTasks: complete,
                pendingTasks: pending,
              ),
              TotalAndCompleteTasks(
                total: chartViewModel.totalTasks,
                complete: complete,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text('Progresso dos grupos',
                    style: theme.textTheme.titleMedium),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: chartViewModel.taskGroups.length,
                  itemBuilder: (context, index) {
                    final group = chartViewModel.taskGroups[index];

                    final tasksInfo =
                        chartViewModel.completedAndPendingGroupTasks(group.id);
                    final completeTasks = tasksInfo['complete'] as double;
                    final pendingTasks = tasksInfo['pending'] as double;

                    return ListTileChart(
                      groupName: group.name,
                      completeTasks: completeTasks,
                      pendingTasks: pendingTasks,
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
