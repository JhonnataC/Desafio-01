import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  final double completeTasks;
  final double pendingTasks;

  const CustomPieChart({
    super.key,
    required this.completeTasks,
    required this.pendingTasks,
  });

  double get percentage {
    if (completeTasks == 0) return 0;

    return (completeTasks / (completeTasks + pendingTasks)) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height -
        56 -
        MediaQuery.of(context).padding.top;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        height: heigth * 0.39,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Progresso do Total de Tarefas',
              style: theme.textTheme.titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 250,
                  width: 230,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: width * 0.15,
                          startDegreeOffset: -90,
                          borderData: FlBorderData(show: false),
                          sections: [
                            PieChartSectionData(
                              value: completeTasks,
                              color: theme.colorScheme.secondary,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              value: pendingTasks,
                              color: theme.colorScheme.onSurface,
                              showTitle: false,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${percentage.toStringAsFixed(0)}%',
                        style: theme.textTheme.headlineLarge,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Completas',
                          style: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Pendentes',
                          style: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
