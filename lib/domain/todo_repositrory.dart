import '../data/models/todo_model.dart';
import 'entities/todo_entities.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoEntity todo);
  Future<void> deleteTodo(int index);
  Future<void> editTodo(int index, TodoEntity updatedTodo);
  Future<TodoModel> getTodoByIndex(int index);
}