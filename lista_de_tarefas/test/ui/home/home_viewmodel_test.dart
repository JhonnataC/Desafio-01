import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/domain/models/task.dart';
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
    'Testes da home view model',
    () {
      test(
        'Deve adicionar uma nova task na variável da view model',
        () {
          homeViewModel.addTask('fazer compras');

          expect(homeViewModel.taskList.length, 1);
          expect(homeViewModel.taskList.first.taskText, 'fazer compras');
          expect(homeViewModel.taskList.first.isDone, false);
        },
      );

      test(
        'Deve alternar o status da uma task',
        () {
          homeViewModel.addTask('fazer compras');
          final taskId = homeViewModel.taskList.first.id;

          homeViewModel.toggleTaskStatus(taskId);
          expect(homeViewModel.taskList.first.isDone, true);

          homeViewModel.toggleTaskStatus(taskId);
          expect(homeViewModel.taskList.first.isDone, false);
        },
      );

      test(
        'Deve editar uma task da lista de tasks',
        () {
          homeViewModel.addTask('estudar');
          final taskId = homeViewModel.taskList.first.id;

          homeViewModel.editTask(taskId, 'fazer compras');

          expect(homeViewModel.taskList.first.taskText, 'fazer compras');
          expect(homeViewModel.taskList.first.isDone, false);
          expect(homeViewModel.taskList.first.id, taskId);
        },
      );

      test(
        'Deve deletar uma task da lista de tasks',
        () {
          homeViewModel.addTask('fazer compras');
          final taskId = homeViewModel.taskList.first.id;

          homeViewModel.deleteTask(taskId);
          expect(
              homeViewModel.taskList.any((task) => task.id == taskId), false);
          expect(homeViewModel.taskList, isEmpty);
        },
      );

      test(
        'Deve carregar as tasks do armazenamento local para a variável da view model',
        () async {
          final mockTasks = [
            Task(id: '1', taskText: 'fazer compras', isDone: false).toMap(),
            Task(id: '2', taskText: 'estudar', isDone: true).toMap(),
          ];

          SharedPreferences.setMockInitialValues({
            'tasks': jsonEncode(mockTasks),
          });

          await homeViewModel.loadTasks();
          expect(homeViewModel.taskList.length, 2);
        },
      );
    },
  );
}
