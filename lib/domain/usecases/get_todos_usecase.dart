

import 'package:todo_assesment/data/models/todo_model.dart';

import '../todo_repositrory.dart';

class GetTodosUseCase {
  final TodoRepository repository;

  GetTodosUseCase(this.repository);

  Future<List<TodoModel>> call() {
    return repository.getTodos();
  }
}