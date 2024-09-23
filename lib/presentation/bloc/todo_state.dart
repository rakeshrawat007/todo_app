
import '../../data/models/todo_model.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodosLoadedState extends TodoState {
  final List<TodoModel> todos;

  TodosLoadedState(this.todos);
}