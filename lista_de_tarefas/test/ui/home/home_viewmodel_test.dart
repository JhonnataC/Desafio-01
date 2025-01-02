import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/domain/models/task.dart';
import 'package:lista_de_tarefas/domain/models/task_group.dart';
import 'package:lista_de_tarefas/ui/home/view_models/home_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late HomeViewModel homeViewModel;

  setUp(
    () {
      SharedPreferences.setMockInitialValues({});
      homeViewModel = HomeViewModel();
    },
  );

  group(
    'Teste da home view model',
    () {
      test(
        'Deve adicionar um grupo de tasks na variavel da view model',
        () {
          homeViewModel.addTaskGroup('escola');
          homeViewModel.addTaskGroup('trabalho');

          expect(homeViewModel.taskGroups.length, 2);
          expect(homeViewModel.taskGroups.first.name, 'escola');
          expect(homeViewModel.taskGroups.last.name, 'trabalho');
        },
      );

      test(
        'Deve editar um grupo de tasks',
        () {
          homeViewModel.addTaskGroup('escola');
          final groupId = homeViewModel.taskGroups.first.id;

          homeViewModel.editTaskGroup(groupId, 'estudos');

          expect(homeViewModel.taskGroups.first.name, 'estudos');
        },
      );

      test(
        'Deve remover um grupo de tasks',
        () {
          homeViewModel.addTaskGroup('estudos');
          final groupId = homeViewModel.taskGroups.first.id;

          homeViewModel.deleteTaskGroup(groupId);

          expect(homeViewModel.taskGroups, isEmpty);
        },
      );

      test(
        'Deve carregar os grupos de tasks na variavel da view model',
        () async {
          SharedPreferences.setMockInitialValues({});

          final List<Task> taskList = [
            Task(id: '1', taskText: 'estudar matematica'),
            Task(id: '2', taskText: 'estudar historia'),
          ];

          final List<TaskGroup> taskGroups = [
            TaskGroup(id: '1', name: 'escola', tasks: taskList),
          ];

          await LocalDataService.saveTaskGroupsToLocalStorage(taskGroups);

          await homeViewModel.loadTaskGroups();

          expect(homeViewModel.taskGroups, isNotEmpty);
          expect(homeViewModel.taskGroups.first.name, 'escola');
          expect(homeViewModel.taskGroups.first.tasks.length, 2);
        },
      );
    },
  );
}
