import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/core/theme/colors.dart';
import 'package:lista_de_tarefas/ui/core/widgets/custom_app_bar.dart';
import 'package:lista_de_tarefas/ui/core/widgets/date_and_screen_title.dart';
import 'package:lista_de_tarefas/ui/core/widgets/floating_action_button.dart';
import 'package:lista_de_tarefas/ui/home/view_models/home_viewmodel.dart';
import 'package:lista_de_tarefas/ui/home/widgets/list_tile.dart';
import 'package:lista_de_tarefas/ui/home/widgets/show_confirm_box_dialog.dart';
import 'package:lista_de_tarefas/ui/home/widgets/show_form_dialog.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel homeViewModel;

  const HomeScreen({super.key, required this.homeViewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openForm({String? editValue, required Function(String) onSubmit}) {
    showDialog(
      context: context,
      builder: (_) {
        return ShowFormDialog(editValue: editValue, onSubmit: onSubmit);
      },
    );
  }

  void _showConfirmBox(
      {required String groupName, required Function() onSubmit}) {
    showDialog(
      context: context,
      builder: (_) {
        return ShowConfirmBoxDialog(groupName: groupName, onSubmit: onSubmit);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widget.homeViewModel.loadTaskGroups();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.homeViewModel.loadTaskGroups();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = widget.homeViewModel;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateAndScreenTitle(title: 'Minhas Tarefas'),
          SizedBox(height: 30),
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
                          return CustomListTile(
                            taskGroup: taskGroup,
                            onEdit: () => _openForm(
                              editValue: taskGroup.name,
                              onSubmit: (newName) => viewModel.editTaskGroup(
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
          SizedBox(height: 70)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
        label: 'Add. grupo',
        onPressed: () => _openForm(
          onSubmit: viewModel.addTaskGroup,
        ),
      ),
    );
  }
}
