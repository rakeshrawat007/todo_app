import 'package:hive/hive.dart';
import 'package:todo_assesment/domain/entities/todo_entities.dart';
import '../../core/utils/hive_service.dart';
import '../../domain/todo_repositrory.dart';
import '../models/todo_model.dart'; // Import the interface

class TodoDataRepository implements TodoRepository {
  final Box<TodoModel> todoBox = HiveService().getTodoBox();

  @override
  Future<List<TodoModel>> getTodos() async {
    return Future.value(todoBox.values.toList());
  }


  @override
  Future<void> addTodo(TodoEntity todo) async {
    await todoBox.add(TodoModel.fromEntity(todo));
  }

  @override
  Future<TodoModel> getTodoByIndex(int index) async {
    return todoBox.values.toList()[index];
  }

  @override
  Future<void> deleteTodo(int index) async {
    await todoBox.deleteAt(index);
  }

  @override
  Future<void> editTodo(int index, TodoEntity updatedTodo) async {
    await todoBox.putAt(index, TodoModel.fromEntity(updatedTodo));
  }
}