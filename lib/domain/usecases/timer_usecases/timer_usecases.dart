// import 'dart:async';
// import '../../../presentation/bloc/todo_state.dart';
// import '../../entities/todo_entities.dart';
// import '../../todo_repositrory.dart';
// import '../edit_todo_usecase.dart'; // Adjust the path as necessary
//
// class TimerUseCase {
//   final EditTodoUseCase editTodo;
//   final TodoRepository repository;
//   Timer? _timer; // Private Timer instance
//   int _remainingTime = 0; // Remaining time in seconds
//   bool _isRunning = false; // Timer running state
//   final _remainingTimeController = StreamController<int>.broadcast(); // Stream controller
//
//   TimerUseCase(this.editTodo, this.repository);
//
//   // Starts the timer with the specified duration
//   void start(int duration) {
//     if (_isRunning) return; // Prevent starting if already running
//     _remainingTime = duration; // Set the remaining time
//     _isRunning = true;
//
//     _timer?.cancel(); // Cancel any existing timer
//
//     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       if (_remainingTime > 0) {
//         _remainingTime--;
//         _remainingTimeController.add(_remainingTime); // Emit remaining time
//       } else {
//         _onTimerCompleted();
//       }
//     });
//   }
//
//   // Pauses the timer
//   void pause() {
//     if (!_isRunning) return; // Prevent pausing if not running
//     _timer?.cancel(); // Stop the timer
//     _isRunning = false; // Update running state
//     _updateTodoStatus(index,TodoStatus.InProgress); // Update status to paused
//   }
//
//   // Resumes the timer from the current remaining time
//   void resume() {
//     if (_isRunning) return; // Prevent resuming if already running
//     if (_remainingTime > 0) {
//       _isRunning = true; // Update running state
//       start(_remainingTime); // Resume timer with remaining time
//       _updateTodoStatus(index,TodoStatus.InProgress); // Update status to in-progress
//     }
//   }
//
//   // Restarts the timer with a new duration
//   void restart(int duration) {
//     _isRunning = false; // Reset running state
//     start(duration);
//     _updateTodoStatus();
//   }
//
//   // Handles updates when the timer changes
//   void _onTimerChanged() {
//     // Optional: Notify observers or update UI
//     print('Remaining Time: $_remainingTime seconds');
//   }
//
//   // Handles actions when the timer completes
//   void _onTimerCompleted() {
//     _timer?.cancel();
//     _isRunning = false; // Update running state
//     print('Timer completed!');
//   //  _updateTodoStatus(TodoStatus.Done); // Update status to done
//   }
//   Future<void> _updateTodoStatus(TodoEntity todo, TodoStatus status,int index) async {
//     final updatedTodo = todo.copyWith(status: status);
//     await editTodo.call(index, updatedTodo); // Save updated status
//   }
//
//   // Provides a stream of remaining time
//   Stream<int> remainingTimeStream() {
//     return _remainingTimeController.stream; // Provide the stream
//   }
//
//   // Disposes the timer and cleans up the stream controller
//   void dispose() {
//     _timer?.cancel(); // Clean up
//     _remainingTimeController.close(); // Close the stream controller
//   }
// }