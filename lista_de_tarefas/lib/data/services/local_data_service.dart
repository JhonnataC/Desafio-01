import 'dart:convert';

import 'package:lista_de_tarefas/domain/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataService {
  static const String localDataServiceKey = 'tasks';

  static Future<void> saveTasksToLocalStorage(List<Task> taskList) async {
    if (taskList.isEmpty) return;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final tasksJson = _encodeTasksToJson(taskList);
      await prefs.setString(localDataServiceKey, tasksJson);
    } catch (e) {
      return;
    }
  }

  static Future<List<Task>> loadTasksFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final tasksJson = prefs.getString(localDataServiceKey);

      if (tasksJson == null) return [];

      return _decodeTasksFromJson(tasksJson);
    } catch (e) {
      return [];
    }
  }

  static String _encodeTasksToJson(List<Task> taskList) {
    return jsonEncode(
      taskList.map((task) => task.toMap()).toList(),
    );
  }

  static List<Task> _decodeTasksFromJson(String tasksJson) {
    final List<dynamic> tasksMapList = jsonDecode(tasksJson);

    return tasksMapList.map((taskMap) => Task.fromMap(taskMap)).toList();
  }
}
