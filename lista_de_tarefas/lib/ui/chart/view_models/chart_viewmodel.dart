import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/domain/models/task.dart';

class ChartViewModel extends ChangeNotifier {
  List<Task> _taskList = [];

  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList);

  int get totalTasks => _taskList.length;

  int get completedTasks {
    int counter = 0;
    for (var task in _taskList) {
      if (task.isDone == true) counter++;
    }
    return counter;
  }

  int get pendingTasks {
    int counter = 0;
    for (var task in _taskList) {
      if (task.isDone == false) counter++;
    }
    return counter;
  }

  void loadTasks() async {
    _taskList = await LocalDataService.loadTasksFromLocalStorage();
    notifyListeners();
  }
}
