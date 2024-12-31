import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/domain/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group(
    'Testes de LocalDataService',
    () {
      test(
        'Deve salvar uma lista de tasks no armazenamento local',
        () async {
          SharedPreferences.setMockInitialValues({});

          final List<Task> taskList = [
            Task(id: '1', taskText: 'fazer compras'),
            Task(id: '2', taskText: 'verificar email'),
            Task(id: '3', taskText: 'ir ao correio'),
            Task(id: '4', taskText: 'comprar fone'),
          ];

          await LocalDataService.saveTasksToLocalStorage(taskList);

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final savedJson =
              prefs.getString(LocalDataService.localDataServiceKey);

          expect(savedJson, isNotNull);

          final List<dynamic> tasksMapList = jsonDecode(savedJson!);

          tasksMapList.map((taskMap) => Task.fromMap(taskMap)).toList();

          expect(tasksMapList.length, taskList.length);
          expect(tasksMapList[0]['taskText'], 'fazer compras');
          expect(tasksMapList[3]['taskText'], 'comprar fone');
        },
      );

      test(
        'Deve carregar uma lista de tasks salvas localmente',
        () async {
          SharedPreferences.setMockInitialValues({});

          final List<Task> taskList = [
            Task(id: '1', taskText: 'fazer compras'),
            Task(id: '2', taskText: 'verificar email'),
          ];

          await LocalDataService.saveTasksToLocalStorage(taskList);

          final loadedTasks =
              await LocalDataService.loadTasksFromLocalStorage();

          expect(loadedTasks.length, 2);
          expect(loadedTasks[0].taskText, 'fazer compras');
          expect(loadedTasks[1].taskText, 'verificar email');
        },
      );

      test(
        'Deve retornar uma lista vazia',
        () async {
          SharedPreferences.setMockInitialValues({});

          final loadedTasks =
              await LocalDataService.loadTasksFromLocalStorage();

          expect(loadedTasks, isEmpty);
        },
      );

      test(
        'Deve retornar uma lista vazia se o json for inválido',
        () async {
          SharedPreferences.setMockInitialValues({
            LocalDataService.localDataServiceKey: 'json inválido',
          });

          final loadedTasks =
              await LocalDataService.loadTasksFromLocalStorage();

          expect(loadedTasks, isEmpty);
        },
      );
    },
  );
}
