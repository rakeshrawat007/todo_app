import '../../data/models/todo_model.dart';

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

// Add these events
class StartTimerEvent extends TodoEvent {
  final int index;

  StartTimerEvent(this.index);
}

class PauseTimerEvent extends TodoEvent {
  final int index;

  PauseTimerEvent(this.index);
}

class CancelTimerEvent extends TodoEvent {
  final int index;

  CancelTimerEvent(this.index);
}