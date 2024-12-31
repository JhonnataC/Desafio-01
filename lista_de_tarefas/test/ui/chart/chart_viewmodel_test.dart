import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/domain/models/task.dart';
import 'package:lista_de_tarefas/ui/chart/view_models/chart_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late ChartViewModel chartViewModel;

  setUp(
    () {
      final mockTasks = [
        Task(id: '1', taskText: 'fazer compras', isDone: true).toMap(),
        Task(id: '3', taskText: 'caminhar', isDone: true).toMap(),
        Task(id: '2', taskText: 'estudar testes em fluter').toMap(),
        Task(id: '4', taskText: 'verificar email').toMap(),
      ];

      SharedPreferences.setMockInitialValues({'tasks': jsonEncode(mockTasks)});
      chartViewModel = ChartViewModel();
      chartViewModel.loadTasks();
    },
  );

  group(
    'Testes da chart view model',
    () {
      test(
        'Deve retornar a quantidade total de tasks',
        () {
          final totalTasks = chartViewModel.totalTasks;
          expect(totalTasks, 4);
        },
      );
      test(
        'Deve retornar a quantidade de tasks concluídas',
        () {
          final completedTasks = chartViewModel.completedTasks;
          expect(completedTasks, 2);
        },
      );
      test(
        'Deve retornar a quantidade de tasks pendentes',
        () {
          final pendingTasks = chartViewModel.pendingTasks;
          expect(pendingTasks, 2);
        },
      );
    },
  );
}
