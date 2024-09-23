import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_assesment/domain/usecases/edit_todo_usecase.dart';
import 'package:todo_assesment/presentation/bloc/todo_bloc.dart';
import 'package:todo_assesment/presentation/bloc/todo_event.dart';
import 'package:todo_assesment/presentation/screens/todo_screen.dart';
import 'data/models/todo_model.dart';
import 'domain/todo_repositrory.dart';
import 'domain/usecases/add_todo_usecase.dart';
import 'domain/usecases/delete_todo_usecase.dart';
import 'domain/usecases/get_todos_usecase.dart';
// Adjust the import as needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<TodoModel>(TodoModelAdapter());
  await Hive.openBox<TodoModel>('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final todoRepository = TodoRepository(); // Create an instance of your repository

    return BlocProvider(
      create: (_) => TodoBloc(
        editTodo: EditTodoUseCase(todoRepository),
        addTodo: AddTodoUseCase(todoRepository), // Pass the repository here
        getTodos: GetTodosUseCase(todoRepository), // Pass the repository here
        deleteTodo: DeleteTodoUseCase(todoRepository), // Pass the repository here
      )..add(LoadTodosEvent()), // Load todos on startup
      child:  const MaterialApp(home: TodoListScreen(),),
    );
  }
}