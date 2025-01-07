import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/domain/models/task.dart';
import 'package:lista_de_tarefas/domain/models/task_group.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late List<Task> taskList;
  late List<TaskGroup> taskGroups;

  setUp(
    () {
      SharedPreferences.setMockInitialValues({});

      taskList = [
        Task(id: '1', taskText: 'estudar matematica'),
        Task(id: '2', taskText: 'estudar historia'),
      ];

      taskGroups = [
        TaskGroup(id: '1', name: 'escola', tasks: taskList),
      ];
    },
  );

  group(
    'Testes de LocalDataService',
    () {
      test(
        'Deve salvar uma lista de grupos de tarefa no armazenamento local',
        () async {
          await LocalDataService.saveTaskGroupsToLocalStorage(taskGroups);

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final savedJson =
              prefs.getString(LocalDataService.localDataServiceKey);

          expect(savedJson, isNotNull);

          final List<dynamic> taskGroupsMapList = jsonDecode(savedJson!);

          expect(taskGroupsMapList.length, taskGroups.length);
          expect(taskGroupsMapList[0]['name'], 'escola');
          expect(taskGroupsMapList[0]['tasks'].length, 2);
        },
      );

      test(
        'Deve salvar uma lista de tasks em um grupo no armazenamento local',
        () async {
          await LocalDataService.saveTaskGroupsToLocalStorage(taskGroups);

          final List<Task> taskList = [
            Task(id: '1', taskText: 'estudar matematica'),
            Task(id: '2', taskText: 'estudar historia'),
            Task(id: '3', taskText: 'lição de quimica'),
          ];

          taskGroups.first.tasks = taskList;

          final groupId = taskGroups.first.id;
          final tasks = taskGroups.first.tasks;

          await LocalDataService.saveTaskListToGroupInLocalStorage(
              groupId, tasks);

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final savedJson =
              prefs.getString(LocalDataService.localDataServiceKey);

          expect(savedJson, isNotNull);

          final List<dynamic> taskGroupsMapList = jsonDecode(savedJson!);

          expect(taskGroupsMapList.length, taskGroups.length);
          expect(taskGroupsMapList.first['name'], 'escola');
          expect(taskGroupsMapList.first['tasks'].length, 3);
        },
      );

      test(
        'Deve carregar uma lista grupos salvos localmente',
        () async {
          await LocalDataService.saveTaskGroupsToLocalStorage(taskGroups);

          final loadedTaskGroups =
              await LocalDataService.loadTaskGroupsFromLocalStorage();

          expect(loadedTaskGroups.length, taskGroups.length);
          expect(loadedTaskGroups[0].name, 'escola');
          expect(loadedTaskGroups[0].tasks.length, 2);
        },
      );

      test(
        'Deve retornar uma lista vazia',
        () async {
          SharedPreferences.setMockInitialValues({});

          final loadedTaskGroups =
              await LocalDataService.loadTaskGroupsFromLocalStorage();

          expect(loadedTaskGroups, isEmpty);
        },
      );

      test(
        'Deve retornar uma lista vazia se o json for inválido',
        () async {
          SharedPreferences.setMockInitialValues({
            LocalDataService.localDataServiceKey: 'json inválido',
          });

          final loadedTaskGroups =
              await LocalDataService.loadTaskGroupsFromLocalStorage();

          expect(loadedTaskGroups, isEmpty);
        },
      );

      test(
        'Deve retornar uma lista de tasks a partir do id de um grupo',
        () async {
          await LocalDataService.saveTaskGroupsToLocalStorage(taskGroups);

          final loadedTaskGroups =
              await LocalDataService.loadTaskGroupsFromLocalStorage();
          final groupId = loadedTaskGroups.first.id;

          final loadedTasks =
              await LocalDataService.loadTasksFromGroupInLocalStorage(groupId);

          expect(loadedTasks['groupName'], 'escola');
          expect(loadedTasks['tasks'].first.taskText, 'estudar matematica');
        },
      );
    },
  );
}
