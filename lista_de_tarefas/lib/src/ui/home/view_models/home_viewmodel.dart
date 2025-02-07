import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:lista_de_tarefas/src/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/src/domain/models/task_group.dart';
import 'package:uuid/uuid.dart';

class HomeViewModel extends ChangeNotifier {
  final Uuid _uuid = const Uuid();
  List<TaskGroup> _taskGroups = [];

  UnmodifiableListView<TaskGroup> get taskGroups =>
      UnmodifiableListView(_taskGroups.reversed);

  void addTaskGroup(String name) {
    final newTaskGroup = TaskGroup(
      id: _uuid.v1(),
      name: name,
      tasks: [],
    );
    _taskGroups.add(newTaskGroup);
    _saveTaskGroups();
    notifyListeners();
  }

  void editTaskGroup(String groupId, String newName) {
    for (var taskGroup in _taskGroups) {
      if (taskGroup.id == groupId) taskGroup.name = newName;
    }
    _saveTaskGroups();
    notifyListeners();
  }

  void deleteTaskGroup(String groupId) {
    _taskGroups.removeWhere((taskGroup) => taskGroup.id == groupId);
    _saveTaskGroups();
    notifyListeners();
  }

  Future<void> loadTaskGroups() async {
    _taskGroups = await LocalDataService.loadTaskGroupsFromLocalStorage();
    notifyListeners();
  }

  void _saveTaskGroups() async {
    await LocalDataService.saveTaskGroupsToLocalStorage(_taskGroups);
  }
}
