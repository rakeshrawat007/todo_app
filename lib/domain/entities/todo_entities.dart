class TodoEntity {
  final String title;
  final String description;
  final int timer; // Time in minutes
  final bool isCompleted;
  final bool isRunning;

  TodoEntity({
    required this.title,
    required this.description,
    required this.timer,
    required this.isCompleted,
    required this.isRunning,
  });
}