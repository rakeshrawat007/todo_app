import 'package:hive/hive.dart';

import '../../domain/entities/todo_entities.dart';


part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends TodoEntity {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final int timer;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final bool isRunning;

  TodoModel({
    required this.title,
    required this.description,
    required this.timer,
    required this.isCompleted,
    required this.isRunning,
  }) : super(
    title: title,
    description: description,
    timer: timer,
    isCompleted: isCompleted,
    isRunning: isRunning,
  );

  factory TodoModel.fromEntity(TodoEntity todo) {
    return TodoModel(
      title: todo.title,
      description: todo.description,
      timer: todo.timer,
      isCompleted: todo.isCompleted,
      isRunning: todo.isRunning,
    );
  }
}