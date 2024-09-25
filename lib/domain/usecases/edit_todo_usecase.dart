import '../../presentation/bloc/todo_state.dart';
import '../entities/todo_entities.dart';
import '../todo_repositrory.dart';
import 'dart:async';



class EditTodoUseCase {
  final TodoRepository repository;
  Timer? _timer;
  int _remainingTime = 0;

  EditTodoUseCase(this.repository);


  Future<void> call(int index, TodoEntity updatedTodo) async {
    final existingTodo = await repository.getTodoByIndex(index);

    final updatedTodoWithStatus = existingTodo.copyWith(
      title: updatedTodo.title.isNotEmpty ? updatedTodo.title : null,
      description: updatedTodo.description.isNotEmpty ? updatedTodo.description : null,
      timer: updatedTodo.timer != 0 ? updatedTodo.timer : null,
      status: updatedTodo.status ?? existingTodo.status, // Keep status unless passed
    );

    return repository.editTodo(index, updatedTodoWithStatus);
  }

  // Specific method for updating only the status
  Future<void> updateTodoStatus(int index, TodoStatus newStatus,int remainingtimer) async {
    final todo = await repository.getTodoByIndex(index);
    final updatedTodo = todo.copyWith(status: newStatus,timer: remainingtimer); // Only update status
    return repository.editTodo(index, updatedTodo);
  }

  // Start the timer for the todo
  Future<void> startTodoTimer(int index) async {
    final todo = await repository.getTodoByIndex(index);

    // Update status to InProgress and set the remaining time
    final updatedTodo = todo.copyWith(
      status: TodoStatus.InProgress,
      timer: todo.timer, // Timer continues from its previous state
    );

    _remainingTime = todo.timer;
    await repository.editTodo(index, updatedTodo);

    _startTimer(index); // Start the timer countdown
  }

  // Pause the timer for the todo
  Future<void> pauseTodoTimer(int index) async {
    final todo = await repository.getTodoByIndex(index);

    // Update status to InProgress and save the remaining time
    final updatedTodo = todo.copyWith(
      status: TodoStatus.InProgress, // Keep the InProgress status
      timer: _remainingTime, // Save the remaining time
    );

    _timer?.cancel(); // Cancel the running timer
    await repository.editTodo(index, updatedTodo);
  }

  // Private method to start the countdown timer
  void _startTimer(int index) {
    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (_remainingTime > 0) {
        _remainingTime--;

        final todo = await repository.getTodoByIndex(index);
        final updatedTodo = todo.copyWith(timer: _remainingTime);

        await repository.editTodo(index, updatedTodo);
      } else {
        _timer?.cancel();
        await completeTodoTimer(index); // Mark the todo as completed
      }
    });
  }

  // Complete the timer for the todo
  Future<void> completeTodoTimer(int index) async {
    final todo = await repository.getTodoByIndex(index);

    // Update status to Done when the timer completes
    final updatedTodo = todo.copyWith(
      status: TodoStatus.Done,
      timer: 0, // Set timer to 0 when completed
    );

    await repository.editTodo(index, updatedTodo);
  }

  // Dispose the timer when not needed
  void dispose() {
    _timer?.cancel();
  }
}