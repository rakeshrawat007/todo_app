

import '../entities/todo_entities.dart';
import '../todo_repositrory.dart';

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  Future<void> call(TodoEntity todo) {
    return repository.addTodo(todo);
  }
}