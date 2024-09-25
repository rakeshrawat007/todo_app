import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assesment/domain/usecases/edit_todo_usecase.dart';
import '../../data/models/todo_model.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/timer_usecases/timer_usecases.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> with WidgetsBindingObserver{
  Timer? _timer;
  int remainingTime = 0; // Keep track of remaining time in seconds for each task

  final GetTodosUseCase getTodos;
  final AddTodoUseCase addTodo;
  final DeleteTodoUseCase deleteTodo;
  final EditTodoUseCase editTodo;

  //timer use cases
  //final TimerUseCase startTimer;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.deleteTodo,
    required this.editTodo,
   // required this.startTimer,
  }) : super(TodoInitial()) {
    // on<StartTodoTimerEvent>(_onStartTimer);
    // on<PauseTodoTimerEvent>(_onPauseTimer);
    // on<TickTodoTimerEvent>(_onTickTimer);
    // on<RestartTodoTimerEvent>(_onRestartTimer);
    WidgetsBinding.instance.addObserver(this);




    on<LoadTodosEvent>((event, emit) async {
      final todos = await getTodos();
      emit(TodosLoadedState(todos)); // Cast to List<TodoModel>
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
        //startTimer.start(event.index,);
        emit(TodosLoadedState(currentState.todos));
      }
    });

    on<PauseTimerEvent>((event, emit) {
      final currentState = state;
      if (currentState is TodosLoadedState) {
        emit(TodosLoadedState(currentState.todos));
      }
    });

    on<UpdateTodoStatusEvent>((event, emit) async {
      await editTodo.updateTodoStatus(event.index, event.newStatus,event.remainingTime);
      add(LoadTodosEvent());
    });


  }
}