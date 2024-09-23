import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assesment/domain/usecases/edit_todo_usecase.dart';
import '../../data/models/todo_model.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase getTodos;
  final AddTodoUseCase addTodo;
  final DeleteTodoUseCase deleteTodo;
  final EditTodoUseCase editTodo;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.deleteTodo,
    required this.editTodo
  }) : super(TodoInitial()) {
    on<LoadTodosEvent>((event, emit) async {
      final todos = await getTodos();
      emit(TodosLoadedState(todos.cast<TodoModel>())); // Cast to List<TodoModel>
    });

    on<AddTodoEvent>((event, emit) async {
      await addTodo.call(event.todo);
      add(LoadTodosEvent()); // Reload todos after adding
    });

    on<DeleteTodoEvent>((event, emit) async {
      await deleteTodo.call(event.index);
      add(LoadTodosEvent()); // Reload todos after deleting
    });

    on<EditTodoEvent>((event, emit) async {
      await editTodo.call(event.index,event.todo);
      add(LoadTodosEvent()); // Reload todos after deleting
    });
  }
}