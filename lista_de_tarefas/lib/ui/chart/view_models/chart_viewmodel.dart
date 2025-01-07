import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/domain/models/task_group.dart';

class ChartViewModel extends ChangeNotifier {
  List<TaskGroup> _taskGroups = [];

  UnmodifiableListView<TaskGroup> get taskGroups =>
      UnmodifiableListView(_taskGroups);

  double get totalTasks =>
      _taskGroups.fold(0, (sum, group) => sum + group.tasks.length);

  //Retorna o número total de tasks completas e pendentes 
  Map<String, double> get completedAndPendingTasks {
    double complete = 0;
    double pending = 0;

    for (var taskGroup in _taskGroups) {
      for (var task in taskGroup.tasks) {
        if (task.isDone) {
          complete++;
        } else {
          pending++;
        }
      }
    }
    return {'complete': complete, 'pending': pending};
  }

  //Retorna o total de tasks de um grupo
  double totalGroupTasks(String groupId) {
    for (var taskGroup in _taskGroups) {
      if (taskGroup.id == groupId) {
        return taskGroup.tasks.length.toDouble();
      }
    }
    return 0;
  }

  //Retorna as tasks completas e pendentes de um grupo
  Map<String, double> completedAndPendingGroupTasks(String groupId) {
    double complete = 0;
    double pending = 0;

    for (var taskGroup in _taskGroups) {
      if (taskGroup.id == groupId) {
        for (var task in taskGroup.tasks) {
          if (task.isDone) {
            complete++;
          } else {
            pending++;
          }
        }
      }
    }
    return {'complete': complete, 'pending': pending};
  }

  Future<void> loadTaskGroups() async {
    _taskGroups = await LocalDataService.loadTaskGroupsFromLocalStorage();
    notifyListeners();
  }
}
