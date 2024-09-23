import 'package:todo_assesment/domain/entities/todo_entities.dart';

import '../todo_repositrory.dart';

class EditTodoUseCase {
  final TodoRepository repository;

  EditTodoUseCase(this.repository);

  Future<void> call(int index, TodoEntity updatedTodo) {
    return repository.editTodo(index, updatedTodo);
  }
}