import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assesment/domain/usecases/edit_todo_usecase.dart';
import '../../data/models/todo_model.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  Timer? _timer;

  // Other code...

  void _startTimer(int index) {
    final currentState = state;
    if (currentState is TodosLoadedState) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        // Decrease remaining time and update the state
        // Example: Update the corresponding TodoModel's timer
      });
    }
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  void _cancelTimer() {
    _timer?.cancel();
    // Reset the timer to the initial state
  }

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
      final todos = getTodos();
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

    on<StartTimerEvent>((event, emit) {
      final currentState = state;
      if (currentState is TodosLoadedState) {
        final todo = currentState.todos[event.index];
        // Implement logic to start the timer
        // You can use a Timer class for managing the countdown
        // Update the TodoModel's isRunning property
        emit(TodosLoadedState(currentState.todos));
      }
    });

    on<PauseTimerEvent>((event, emit) {
      final currentState = state;
      if (currentState is TodosLoadedState) {
        // Implement logic to pause the timer
        // Update the TodoModel's isRunning property
        emit(TodosLoadedState(currentState.todos));
      }
    });

    on<CancelTimerEvent>((event, emit) {
      final currentState = state;
      if (currentState is TodosLoadedState) {
        // Implement logic to cancel the timer
        // Update the TodoModel's isRunning property and reset timer
        emit(TodosLoadedState(currentState.todos));
      }
    });
  }
}