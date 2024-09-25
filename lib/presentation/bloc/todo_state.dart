
import '../../data/models/todo_model.dart';

enum TodoStatus {
  TODO,
  InProgress,
  Done,
}

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodosLoadedState extends TodoState {
  final List<TodoModel> todos;
  TodosLoadedState(this.todos);
}

// timer_state.dart
abstract class TodoTimerState {
  const TodoTimerState();
}

class TodoTimerInitial extends TodoTimerState {}

class TodoTimerInProgress extends TodoTimerState {
  final int index;
  final int remainingTime;
  TodoTimerInProgress(this.index, this.remainingTime);
}

class TodoTimerPaused extends TodoTimerState {
  final int index;
  final int remainingTime;
  TodoTimerPaused(this.index, this.remainingTime);
}

class TodoTimerCompleted extends TodoTimerState {
  final int index;
  TodoTimerCompleted(this.index);
}