import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_tarefas/domain/models/task_group.dart';
import 'package:lista_de_tarefas/ui/core/widgets/check.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ListTileHome extends StatefulWidget {
  final TaskGroup taskGroup;
  final void Function() onEdit;
  final void Function() onDelete;

  const ListTileHome({
    super.key,
    required this.taskGroup,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<ListTileHome> createState() => _ListTileHomeState();
}

class _ListTileHomeState extends State<ListTileHome> {
  late Map<String, int> taskInfo;

  Map<String, int> get completedAndTotalTasks {
    int complete = 0;
    int total = 0;

    for (var task in widget.taskGroup.tasks) {
      if (task.isDone) {
        complete++;
      }
      total++;
    }
    return {'complete': complete, 'total': total};
  }

  @override
  void initState() {
    super.initState();
    taskInfo = completedAndTotalTasks;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Slidable(
        key: ValueKey(widget.taskGroup.id),
        endActionPane: ActionPane(
          extentRatio: 0.45,
          motion: const DrawerMotion(),
          children: [
            // Envolvendo os SlidableActions em Theme pra conseguir mudar a cor dos icons
            Theme(
              data: Theme.of(context).copyWith(
                outlinedButtonTheme: const OutlinedButtonThemeData(
                  style: ButtonStyle(
                    iconColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
              ),
              child: SlidableAction(
                onPressed: (_) => widget.onEdit(),
                borderRadius: BorderRadius.circular(10),
                autoClose: true,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                backgroundColor: theme.colorScheme.secondary,
                icon: LucideIcons.edit,
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                outlinedButtonTheme: const OutlinedButtonThemeData(
                  style: ButtonStyle(
                    iconColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
              ),
              child: SlidableAction(
                onPressed: (_) => widget.onDelete(),
                borderRadius: BorderRadius.circular(10),
                autoClose: true,
                backgroundColor: theme.colorScheme.secondary,
                icon: LucideIcons.trash2,
              ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            onTap: () => context.push('/list/${widget.taskGroup.id}'),
            leading: (taskInfo['complete'] == taskInfo['total'] &&
                    taskInfo['total'] != 0)
                ? const Check()
                : const Icon(
                    LucideIcons.circle,
                  ),
            title: Text(
              toBeginningOfSentenceCase(widget.taskGroup.name),
              style: theme.textTheme.titleSmall,
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${taskInfo['complete']}/${taskInfo['total']}',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
