import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lista_de_tarefas/routing/routes.dart';
import 'package:lista_de_tarefas/ui/core/widgets/custom_app_bar.dart';
import 'package:lista_de_tarefas/ui/core/widgets/date_and_screen_title.dart';
import 'package:lista_de_tarefas/ui/core/widgets/custom_floating_action_button.dart';
import 'package:lista_de_tarefas/ui/home/view_models/home_viewmodel.dart';
import 'package:lista_de_tarefas/ui/home/widgets/list_tile_home.dart';
import 'package:lista_de_tarefas/ui/home/widgets/show_confirm_box_dialog.dart';
import 'package:lista_de_tarefas/ui/home/widgets/show_form_dialog_home.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel homeViewModel;

  const HomeScreen({super.key, required this.homeViewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openForm({String? editValue, required Function(String) onSubmit}) {
    final bottomDistance = MediaQuery.of(context).viewInsets.bottom;
    showDialog(
      context: context,
      builder: (_) {
        return ShowFormDialogHome(
          editValue: editValue,
          onSubmit: onSubmit,
          bottomDistance: bottomDistance,
        );
      },
    );
  }

  void _showConfirmBox(
      {required String groupName, required Function() onSubmit}) {
    showDialog(
      context: context,
      builder: (_) {
        return ShowConfirmBoxDialogHome(
          groupName: groupName,
          onSubmit: onSubmit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = widget.homeViewModel;

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: CustomAppBar(
        action: IconButton(
          onPressed: () => context.push(Routes.chart),
          icon: const Icon(
            LucideIcons.pieChart,
            size: 20,
          ),
        ),
      ),
      body: FutureBuilder(
        future: viewModel.loadTaskGroups(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.secondary,
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DateAndScreenTitle(title: 'Minhas Tarefas'),
                const SizedBox(height: 30),
                ListenableBuilder(
                  listenable: viewModel,
                  builder: (context, _) {
                    return viewModel.taskGroups.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                'Adicione os seus grupos de tarefas!',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: viewModel.taskGroups.length,
                              itemBuilder: (_, index) {
                                final taskGroup = viewModel.taskGroups[index];
                                return ListTileHome(
                                  key: ValueKey(taskGroup.id),
                                  taskGroup: taskGroup,
                                  onEdit: () => _openForm(
                                    editValue: taskGroup.name,
                                    onSubmit: (newName) =>
                                        viewModel.editTaskGroup(
                                      taskGroup.id,
                                      newName,
                                    ),
                                  ),
                                  onDelete: () => _showConfirmBox(
                                    groupName: taskGroup.name,
                                    onSubmit: () =>
                                        viewModel.deleteTaskGroup(taskGroup.id),
                                  ),
                                );
                              },
                            ),
                          );
                  },
                ),
                const SizedBox(height: 70)
              ],
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
        label: 'Add. Grupo',
        onPressed: () => _openForm(
          onSubmit: viewModel.addTaskGroup,
        ),
      ),
    );
  }
}
