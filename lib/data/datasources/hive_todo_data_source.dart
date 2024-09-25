// import 'package:hive/hive.dart';
// import 'package:todo_assesment/data/models/todo_model.dart';
//
// class HiveTodoDataSource {
//   final Box<TodoModel> todoBox;
//
//   HiveTodoDataSource(this.todoBox);
//
//    List<TodoModel> getAllTodos() {
//     return todoBox.values.toList();
//   }
//
//   Future<void> addTodo(TodoModel todo) async {
//     await todoBox.add(todo);
//   }
//
//   Future<void> deleteTodo(int index) async {
//     await todoBox.deleteAt(index);
//   }
//
//   Future<void> updateTodo(int index, TodoModel todo) async {
//     await todoBox.putAt(index, todo);
//   }
// }
