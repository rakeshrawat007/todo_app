import 'package:hive/hive.dart';
import 'package:todo_assesment/domain/entities/todo_entities.dart';
import '../../core/utils/hive_service.dart';
import '../data/models/todo_model.dart';

class TodoRepository {
  final Box<TodoModel> todoBox = HiveService().getTodoBox();

  List<TodoModel> getTodos() {
    return todoBox.values.toList();
  }

  Future<void> addTodo(TodoEntity todo) async {
    await todoBox.add(TodoModel.fromEntity(todo));
  }

  Future<void> deleteTodo(int index) async {
    await todoBox.deleteAt(index);
  }

  Future<void> editTodo(int index, TodoEntity updatedTodo) async {
    await todoBox.putAt(index, TodoModel.fromEntity(updatedTodo));
  }
}