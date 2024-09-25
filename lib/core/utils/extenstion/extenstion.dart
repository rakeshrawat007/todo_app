import 'package:flutter/material.dart';
import 'package:todo_assesment/presentation/bloc/todo_state.dart';

extension TodoStatusColorExtension on TodoStatus {
  Color getColor() {
    switch (this) {
      case TodoStatus.TODO:
        return Colors.green;
      case TodoStatus.InProgress:
        return Colors.orange;
      case TodoStatus.Done:
        return Colors.yellow;
      default:
        return Colors.white; // Fallback color if needed
    }
  }


}

extension TimeStringExtension on String {
  // Convert HH:mm time string into total minutes
  int toMinutes() {
    try {
      List<String> timeParts = this.split(':');
      int hours = int.parse(timeParts[0]); // Parse hours
      int minutes = int.parse(timeParts[1]); // Parse minutes
      return (hours * 60) + minutes; // Return total minutes
    } catch (e) {
      throw FormatException("Invalid time format. Expected HH:mm format.");
    }
  }
}

extension TimeFormatter on int {
  String toMinutesSeconds() {
    int minutes = this ~/ 60;
    int seconds = this % 60;

    // If seconds are less than 10, pad with a leading zero
    String formattedSeconds = seconds < 10 ? '0$seconds' : '$seconds';

    return '$minutes:$formattedSeconds';
  }
}