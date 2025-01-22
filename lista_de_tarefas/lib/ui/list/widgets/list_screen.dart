import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/core/widgets/custom_app_bar.dart';
import 'package:lista_de_tarefas/ui/core/widgets/date_and_screen_title.dart';
import 'package:lista_de_tarefas/ui/core/widgets/custom_floating_action_button.dart';
import 'package:lista_de_tarefas/ui/list/view_models/list_viewmodels.dart';
import 'package:lista_de_tarefas/ui/list/widgets/list_tile_list_screen.dart';
import 'package:lista_de_tarefas/ui/list/widgets/show_confirmbox_dialog_list.dart';
import 'package:lista_de_tarefas/ui/list/widgets/show_form_dialog_list.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ListScreen extends StatefulWidget {
  final ListViewModel listViewModel;

  const ListScreen({super.key, required this.listViewModel});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  void _openForm({String? editValue, required Function(String) onSubmit}) {
    final bottomDistance = MediaQuery.of(context).viewInsets.bottom;
    showDialog(
      context: context,
      builder: (_) {
        return ShowFormDialogList(
          editValue: editValue,
          onSubmit: onSubmit,
          bottomDistance: bottomDistance, 
        );
      },
    );
  }

  void _showConfirmBox(
      {required String taskText, required Function() onSubmit}) {
    showDialog(
      context: context,
      builder: (_) {
        return ShowConfirmBoxDialogList(
          taskText: taskText,
          onSubmit: onSubmit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = widget.listViewModel;

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: CustomAppBar(
        action: IconButton(
          onPressed: widget.listViewModel.sortList,
          icon: const Icon(
            LucideIcons.filter,
            size: 20,
          ),
        ),
      ),
      body: FutureBuilder(
        future: viewModel.loadTasksFromGroup(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateAndScreenTitle(title: viewModel.groupName),
              const SizedBox(height: 30),
              ListenableBuilder(
                listenable: viewModel,
                builder: (context, _) {
                  return viewModel.taskList.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text(
                              'Adicione tarefas a esse grupo!',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.taskList.length,
                            itemBuilder: (_, index) {
                              final task = viewModel.taskList[index];
                              return ListTileListScreen(
                                task: task,
                                onEdit: () => _openForm(
                                  editValue: task.taskText,
                                  onSubmit: (newTaskText) => viewModel.editTask(
                                    task.id,
                                    newTaskText,
                                  ),
                                ),
                                onDelete: () => _showConfirmBox(
                                  taskText: task.taskText,
                                  onSubmit: () => viewModel.deleteTask(task.id),
                                ),
                                toggleTaskStatus: () =>
                                    viewModel.toggleTaskStatus(task.id),
                              );
                            },
                          ),
                        );
                },
              ),
              const SizedBox(height: 70)
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
        label: 'Add. Tarefa',
        onPressed: () => _openForm(
          onSubmit: viewModel.addTask,
        ),
      ),
    );
  }
}
