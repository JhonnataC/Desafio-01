// ignore_for_file: prefer_final_fields

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/data/services/local_data_service.dart';
import 'package:lista_de_tarefas/domain/models/task.dart';
import 'package:uuid/uuid.dart';

class ListViewModel extends ChangeNotifier {
  final String _groupId;

  ListViewModel(this._groupId);

  final Uuid _uuid = const Uuid();
  String groupName = '';
  List<Task> _taskList = [];

  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList.reversed);

  // Adiciona uma nova task
  void addTask(String taskText) {
    Task newTask = Task(
      id: _uuid.v1(),
      taskText: taskText,
      isDone: false,
    );

    _taskList.add(newTask);
    _saveTasks();
    notifyListeners();
  }

  // Marca/desmarca a task como feita
  void toggleTaskStatus(String id) {
    for (var task in _taskList) {
      if (task.id == id) task.isDone = !task.isDone;
    }
    _saveTasks();
    notifyListeners();
  }

  // Edita uma task com um novo texto
  void editTask(String id, String newTaskText) {
    for (var task in _taskList) {
      if (task.id == id) task.taskText = newTaskText;
    }
    _saveTasks();
    notifyListeners();
  }

  // Exclui uma task
  void deleteTask(String id) {
    _taskList.removeWhere((task) => task.id == id);
    _saveTasks();
    notifyListeners();
  }

  // Carrega as tasks para _taskList
  Future<void> loadTasksFromGroup() async {
    final Map<String, dynamic> loadedTasks =
        await LocalDataService.loadTasksFromGroupInLocalStorage(_groupId);
    groupName = loadedTasks['groupName'];
    _taskList = loadedTasks['tasks'];
    notifyListeners();
  }

  void _saveTasks() async {
    await LocalDataService.saveTaskListToGroupInLocalStorage(
        _groupId, _taskList);
  }

  void sortList() {
    if (_taskList.first.isDone) {
      _taskList.sort((a, b) => a.isDone == b.isDone
          ? 0
          : a.isDone
              ? 1
              : -1);
    } else {
      _taskList.sort((a, b) => a.isDone == b.isDone
          ? 0
          : !a.isDone
              ? 1
              : -1);
    }
    _saveTasks();
    notifyListeners();
  }
}
