import 'package:todo_assesment/presentation/bloc/todo_state.dart';

import '../../data/models/todo_model.dart';
import '../../domain/entities/todo_entities.dart';

abstract class TodoEvent {}

class LoadTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final TodoModel todo;

  AddTodoEvent(this.todo);
}

class EditTodoEvent extends TodoEvent {
  final int index;
  final TodoModel todo;
  EditTodoEvent(this.index,this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final int index;

  DeleteTodoEvent(this.index);
}

class StartTimerEvent extends TodoEvent {
  final int index;
  final TodoEntity todo;

  StartTimerEvent(this.index, this.todo);
}

class PauseTimerEvent extends TodoEvent {
  final int index;
  PauseTimerEvent(this.index);
}

class ResumeTimerEvent extends TodoEvent {
  final int index;
  ResumeTimerEvent(this.index);
}

class UpdateTodoStatusEvent extends TodoEvent {
  final int index;
  final TodoStatus newStatus;
  final int remainingTime;
  UpdateTodoStatusEvent(this.index, this.newStatus,this.remainingTime);}



class StartTodoTimerEvent extends TodoEvent {
  final int index;
  StartTodoTimerEvent(this.index);
}

class PauseTodoTimerEvent extends TodoEvent {
  final int index;
  PauseTodoTimerEvent(this.index);
}

class RestartTodoTimerEvent extends TodoEvent {
  final int index;
  RestartTodoTimerEvent(this.index);
}

class TickTodoTimerEvent extends TodoEvent {
  final int index;
  final int remainingTime;
  TickTodoTimerEvent(this.index, this.remainingTime);
}