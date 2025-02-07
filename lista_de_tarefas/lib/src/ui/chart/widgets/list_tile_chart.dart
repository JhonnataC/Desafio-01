import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ListTileChart extends StatelessWidget {
  final String groupName;
  final double completeTasks;
  final double pendingTasks;

  const ListTileChart({
    super.key,
    required this.groupName,
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(groupName, style: theme.textTheme.titleSmall),
          subtitle: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Completas: ${completeTasks.toStringAsFixed(0)}',
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Pendentes: ${pendingTasks.toStringAsFixed(0)}',
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ),
            ],
          ),
          trailing: SizedBox(
            height: 25,
            width: 25,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 15,
                    startDegreeOffset: -90,
                    borderData: FlBorderData(show: false),
                    sections: [
                      PieChartSectionData(
                        value: completeTasks,
                        color: theme.colorScheme.tertiary,
                        showTitle: false,
                        radius: 10,
                      ),
                      PieChartSectionData(
                        value: pendingTasks,
                        color: theme.colorScheme.onSurface,
                        showTitle: false,
                        radius: 10,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: theme.textTheme.labelMedium,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
