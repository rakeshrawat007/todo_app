import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final int duration; // Duration in seconds
  final ValueChanged<String> onChanged; // Callback for time change
  final VoidCallback onTimerCompleted; // Callback for timer completion

  TimerWidget({
    required this.duration,
    required this.onChanged,
    required this.onTimerCompleted,
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int remainingTime;
  late bool isRunning;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.duration;
    isRunning = false;
  }

  void startTimer() {
    if (!isRunning) {
      setState(() {
        isRunning = true;
      });

      timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        if (remainingTime > 0) {
          setState(() {
            remainingTime--;
            // Call the onChanged callback with formatted time
            widget.onChanged(formatTime(remainingTime));
          });
        } else {
          timer.cancel();
          widget.onTimerCompleted(); // Callback when timer completes
          setState(() {
            isRunning = false;
          });
        }
      });
    }
  }

  void resetTimer() {
    timer.cancel();
    setState(() {
      remainingTime = widget.duration;
      isRunning = false;
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs'; // Format as MM:SS
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Remaining Time: ${formatTime(remainingTime)}',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: startTimer,
          child: Text(isRunning ? 'Timer Running' : 'Start Timer'),
        ),
        ElevatedButton(
          onPressed: resetTimer,
          child: const Text('Pause'),
        ),
      ],
    );
  }
}