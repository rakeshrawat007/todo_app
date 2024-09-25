import 'package:equatable/equatable.dart';
import '../../presentation/bloc/todo_state.dart';

class TodoEntity extends Equatable {
  final String title;
  final String description;
  final int timer;  // Initial time set for the task
  final TodoStatus status;

  TodoEntity({
    required this.title,
    required this.description,
    required this.timer,
    required this.status,
  });

  // Manually adding the copyWith method to enable partial updates
  TodoEntity copyWith({
    String? title,
    String? description,
    int? timer,
    TodoStatus? status,
  }) {
    return TodoEntity(
      title: title ?? this.title,  // Keep existing title if not provided
      description: description ?? this.description,  // Keep existing description if not provided
      timer: timer ?? this.timer,  // Keep existing timer if not provided
      status: status ?? this.status,  // Keep existing status if not provided
    );
  }

  // Equatable requires this to compare fields for equality
  @override
  List<Object?> get props => [title, description, timer, status];
}