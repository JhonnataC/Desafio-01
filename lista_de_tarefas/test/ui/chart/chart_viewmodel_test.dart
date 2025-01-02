import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/domain/models/task.dart';
import 'package:lista_de_tarefas/domain/models/task_group.dart';
import 'package:lista_de_tarefas/ui/chart/view_models/chart_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late ChartViewModel chartViewModel;
  late List<TaskGroup> taskGroups;

  setUp(
    () async {
      SharedPreferences.setMockInitialValues({});
      chartViewModel = ChartViewModel();

      taskGroups = [
        TaskGroup(
          id: '1',
          name: 'escola',
          tasks: [
            Task(id: '1', taskText: 'estudar historia', isDone: true),
            Task(id: '2', taskText: 'estudar quimica', isDone: true),
          ],
        ),
        TaskGroup(
          id: '2',
          name: 'programação',
          tasks: [
            Task(id: '1', taskText: 'ver flutter', isDone: true),
            Task(id: '2', taskText: 'fazer desafio'),
          ],
        ),
      ];

      await LocalDataService.saveTaskGroupsToLocalStorage(taskGroups);
      await chartViewModel.loadTaskGroups();
    },
  );

  group(
    'Testes da chart view model',
    () {
      test(
        'Deve retornar o total de tasks',
        () {
          final totalTasks = chartViewModel.totalTasks;

          expect(totalTasks, 4);
        },
      );

      test(
        'Deve retornar o total de tarefas completas e pendentes',
        () {
          final completeAndPendings = chartViewModel.completedAndPendingTasks;

          expect(completeAndPendings['complete'], 3);
          expect(completeAndPendings['pending'], 1);
        },
      );

      test(
        'Deve retornar o total de tasks de um grupo',
        () {
          final groupId = taskGroups.first.id;
          final totalGroupTasks = chartViewModel.totalGroupTasks(groupId);

          final groupId2 = taskGroups.last.id;
          final totalGroupTasks2 = chartViewModel.totalGroupTasks(groupId2);

          expect(totalGroupTasks, 2);
          expect(totalGroupTasks2, 2);
        },
      );

      test(
        'Deve retornar o total de tarefas completas e pendentes de um grupo',
        () {
          final groupId = taskGroups.first.id;
          final completedAndPendingGroupTasks =
              chartViewModel.completedAndPendingGroupTasks(groupId);

          final groupId2 = taskGroups.last.id;
          final completedAndPendingGroupTasks2 =
              chartViewModel.completedAndPendingGroupTasks(groupId2);

          expect(completedAndPendingGroupTasks['complete'], 2);
          expect(completedAndPendingGroupTasks['pending'], 0);

          expect(completedAndPendingGroupTasks2['complete'], 1);
          expect(completedAndPendingGroupTasks2['pending'], 1);
        },
      );

      test(
        'Deve carregar os grupos de tasks para a variavel da view model',
        () {
          expect(chartViewModel.taskGroups.length, 2);
          expect(chartViewModel.taskGroups.first.name, 'escola');
          expect(chartViewModel.taskGroups.last.tasks.first.taskText,
              'ver flutter');
        },
      );
    },
  );
}
