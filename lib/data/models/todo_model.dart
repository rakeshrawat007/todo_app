import 'package:hive/hive.dart';
import '../../domain/entities/todo_entities.dart';
import '../../presentation/bloc/todo_state.dart';


@HiveType(typeId: 0)
class TodoModel extends TodoEntity {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final int timer;

  @HiveField(3)
  final int statusIndex;



  TodoModel({
    required this.title,
    required this.description,
    required this.timer,
    required TodoStatus status,
  }) : statusIndex = status.index, // Save the index of the enum
        super(
        title: title,
        description: description,
        timer: timer,
        status: status,
      );

  // Convert from the index back to the enum
  TodoStatus get status => TodoStatus.values[statusIndex];

  factory TodoModel.fromEntity(TodoEntity todo) {
    return TodoModel(
      title: todo.title,
      description: todo.description,
      timer: todo.timer,
      status: todo.status,
    );
  }
}