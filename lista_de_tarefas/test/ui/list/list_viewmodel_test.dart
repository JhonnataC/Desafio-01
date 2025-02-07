import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/src/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/src/domain/models/task.dart';
import 'package:lista_de_tarefas/src/domain/models/task_group.dart';
import 'package:lista_de_tarefas/src/ui/list/view_models/list_viewmodels.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late ListViewModel listViewModel;
  late List<TaskGroup> taskGroups;

  setUp(
    () {
      SharedPreferences.setMockInitialValues({});

      taskGroups = [
        TaskGroup(id: '1', name: 'escola', tasks: []),
      ];

      listViewModel = ListViewModel(taskGroups.first.id);
    },
  );

  group(
    'Testes da list view model',
    () {
      test(
        'Deve adicionar uma nova task na variável da view model',
        () {
          listViewModel.addTask('estudar historia');

          expect(listViewModel.taskList.length, 1);
          expect(listViewModel.taskList.first.taskText, 'estudar historia');
          expect(listViewModel.taskList.first.isDone, false);
        },
      );

      test(
        'Deve alternar o status da uma task',
        () {
          listViewModel.addTask('estudar historia');
          final taskId = listViewModel.taskList.first.id;

          listViewModel.toggleTaskStatus(taskId);
          expect(listViewModel.taskList.first.isDone, true);

          listViewModel.toggleTaskStatus(taskId);
          expect(listViewModel.taskList.first.isDone, false);
        },
      );

      test(
        'Deve editar uma task da lista de tasks',
        () {
          listViewModel.addTask('estudar historia');
          final taskId = listViewModel.taskList.first.id;

          listViewModel.editTask(taskId, 'estudar matematica');

          expect(listViewModel.taskList.first.taskText, 'estudar matematica');
          expect(listViewModel.taskList.first.isDone, false);
          expect(listViewModel.taskList.first.id, taskId);
        },
      );

      test(
        'Deve deletar uma task da lista de tasks',
        () {
          listViewModel.addTask('estudar biologia');
          final taskId = listViewModel.taskList.first.id;

          listViewModel.deleteTask(taskId);
          expect(
              listViewModel.taskList.any((task) => task.id == taskId), false);
          expect(listViewModel.taskList, isEmpty);
        },
      );

      test(
        'Deve carregar as tasks do armazenamento local para a variável da view model',
        () async {
          final tasks = [
            Task(id: '1', taskText: 'estudar historia'),
            Task(id: '2', taskText: 'estudar geografia'),
          ];

          taskGroups.first.tasks = tasks;

          await LocalDataService.saveTaskGroupsToLocalStorage(taskGroups);

          await listViewModel.loadTasksFromGroup();

          expect(listViewModel.groupName, 'escola');
          expect(listViewModel.taskList.length, 2);
          expect(listViewModel.taskList[0].taskText, 'estudar geografia');
          expect(listViewModel.taskList[1].taskText, 'estudar historia');
        },
      );

      test(
        'Deve organizar a lista de tarefas',
        () async {
          final tasks = [
            Task(id: '1', taskText: 'estudar historia', isDone: true),
            Task(id: '2', taskText: 'estudar geografia', isDone: true),
            Task(id: '3', taskText: 'estudar matematica'),
          ];

          taskGroups.first.tasks = tasks;

          await LocalDataService.saveTaskGroupsToLocalStorage(taskGroups);
          await listViewModel.loadTasksFromGroup();

          listViewModel.sortList();

          expect(listViewModel.taskList.first.isDone, true);
          expect(listViewModel.taskList.last.isDone, false);

          listViewModel.sortList();

          expect(listViewModel.taskList.first.isDone, false);
          expect(listViewModel.taskList.last.isDone, true);
        },
      );
    },
  );
}
