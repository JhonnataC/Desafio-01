import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_tarefas/domain/models/task_group.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomListTile extends StatefulWidget {
  final TaskGroup taskGroup;
  final void Function() onEdit;
  final void Function() onDelete;

  const CustomListTile({
    super.key,
    required this.taskGroup,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  late Map<String, int> taskInfo;

  Map<String, int> get completedAndTotalTasks {
    int complete = 0;
    int total = 0;

    for (var task in widget.taskGroup.tasks) {
      if (task.isDone) {
        complete++;
        continue;
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
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => widget.onEdit(),
              borderRadius: BorderRadius.circular(10),
              spacing: 50,
              autoClose: true,
              backgroundColor: theme.colorScheme.secondary,
              // foregroundColor: theme.colorScheme.onSecondary,
              icon: LucideIcons.edit,
            ),
            SlidableAction(
              onPressed: (_) => widget.onDelete(),
              spacing: 50,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: theme.colorScheme.secondary,
              // foregroundColor: theme.colorScheme.onSecondary,
              icon: LucideIcons.trash2,
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
                ? Icon(
                    LucideIcons.checkCircle,
                    color: theme.colorScheme.secondary,
                  )
                : Icon(
                    LucideIcons.circle,
                  ),
            title: Text(
              toBeginningOfSentenceCase(widget.taskGroup.name),
              style: theme.textTheme.titleMedium,
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
