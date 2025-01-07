import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_tarefas/domain/models/task.dart';
import 'package:lista_de_tarefas/ui/core/widgets/check.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ListTileListScreen extends StatefulWidget {
  final Task task;
  final void Function() onEdit;
  final void Function() onDelete;
  final void Function() toggleTaskStatus;

  const ListTileListScreen({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
    required this.toggleTaskStatus,
  });

  @override
  State<ListTileListScreen> createState() =>
      _ListTileListScreenState();
}

class _ListTileListScreenState extends State<ListTileListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Slidable(
        key: ValueKey(widget.task.id),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (_) => widget.toggleTaskStatus(),
              borderRadius: BorderRadius.circular(10),
              spacing: 50,
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: theme.colorScheme.onSecondary,
              icon: LucideIcons.checkCircle,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => widget.onEdit(),
              borderRadius: BorderRadius.circular(10),
              spacing: 50,
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: theme.colorScheme.onSecondary,
              icon: LucideIcons.edit,
            ),
            SlidableAction(
              onPressed: (_) => widget.onDelete(),
              spacing: 50,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: theme.colorScheme.onSecondary,
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
            leading: widget.task.isDone ? const Check() : const Icon(LucideIcons.circle),
            title: Text(
              toBeginningOfSentenceCase(widget.task.taskText),
              style: theme.textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );
  }
}
