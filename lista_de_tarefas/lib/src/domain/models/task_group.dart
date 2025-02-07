import 'package:lista_de_tarefas/src/domain/models/task.dart';

class TaskGroup {
  final String id;
  String name;
  late List<Task> tasks;

  TaskGroup({
    required this.id,
    required this.name,
    required this.tasks,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'tasks': tasks.map((task) => task.toMap()).toList(),
      };

  factory TaskGroup.fromMap(Map<String, dynamic> map) => TaskGroup(
        id: map['id'],
        name: map['name'],
        tasks: (map['tasks'] as List)
            .map(
              (task) => Task.fromMap(task),
            )
            .toList(),
      );
}
