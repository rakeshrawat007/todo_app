

import '../todo_repositrory.dart';

class GetTodosUseCase {
  final TodoRepository repository;

  GetTodosUseCase(this.repository);

  List call() {
    return repository.getTodos();
  }
}