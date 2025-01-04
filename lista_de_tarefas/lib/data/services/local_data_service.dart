import 'dart:convert';

import 'package:lista_de_tarefas/domain/models/task.dart';
import 'package:lista_de_tarefas/domain/models/task_group.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataService {
  static const String localDataServiceKey = 'tasksGroupList';

  static Future<void> saveTaskGroupsToLocalStorage(
      List<TaskGroup> taskGroupList) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final taskGroupsJson = _encodeTaskGroupsToJson(taskGroupList);
      await prefs.setString(localDataServiceKey, taskGroupsJson);
    } catch (e) {
      return;
    }
  }

  static Future<void> saveTaskListToGroupInLocalStorage(
      String groupId, List<Task> newTaskList) async {
    final List<TaskGroup> taskGroups = await loadTaskGroupsFromLocalStorage();

    try {
      for (var taskGroup in taskGroups) {
        if (taskGroup.id == groupId) {
          taskGroup.tasks = newTaskList;
          break;
        }
      }
      await saveTaskGroupsToLocalStorage(taskGroups);
    } catch (e) {
      return;
    }
  }

  static Future<List<TaskGroup>> loadTaskGroupsFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final tasksGroupsJson = prefs.getString(localDataServiceKey);

      if (tasksGroupsJson == null) return [];

      return _decodeTaskGroupsFromJson(tasksGroupsJson);
    } catch (e) {
      return [];
    }
  }

  static Future<List<Task>> loadTasksFromGroupInLocalStorage(
      String groupId) async {
    final List<TaskGroup> taskGroups = await loadTaskGroupsFromLocalStorage();

    try {
      for (var taskGroup in taskGroups) {
        if (taskGroup.id == groupId) return taskGroup.tasks;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static String _encodeTaskGroupsToJson(List<TaskGroup> taskGroupList) {
    return jsonEncode(
      taskGroupList.map((taskGroup) => taskGroup.toMap()).toList(),
    );
  }

  static List<TaskGroup> _decodeTaskGroupsFromJson(String taskGroupsListJson) {
    final List<dynamic> taskGroupsMapList = jsonDecode(taskGroupsListJson);

    return taskGroupsMapList
        .map(
          (taskGroup) => TaskGroup.fromMap(taskGroup),
        )
        .toList();
  }
}
