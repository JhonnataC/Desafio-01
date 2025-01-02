import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/domain/models/task_group.dart';

class ChartViewModel extends ChangeNotifier {
  List<TaskGroup> _taskGroups = [];

  UnmodifiableListView<TaskGroup> get taskGroups =>
      UnmodifiableListView(_taskGroups);

  int get totalTasks =>
      _taskGroups.fold(0, (sum, group) => sum + group.tasks.length);

  Map<String, int> get completedAndPendingTasks {
    int complete = 0;
    int pending = 0;

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

  int totalGroupTasks(String groupId) {
    for (var taskGroup in _taskGroups) {
      if (taskGroup.id == groupId) {
        return taskGroup.tasks.length;
      }
    }
    return 0;
  }

  Map<String, int> completedAndPendingGroupTasks(String groupId) {
    int complete = 0;
    int pending = 0;

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
