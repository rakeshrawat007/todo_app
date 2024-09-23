
import '../todo_repositrory.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<void> call(int index) {
    return repository.deleteTodo(index);
  }
}