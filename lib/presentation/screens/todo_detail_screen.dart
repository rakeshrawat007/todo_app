import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_assesment/core/utils/extenstion/extenstion.dart';
import 'package:todo_assesment/data/models/todo_model.dart';
import 'package:todo_assesment/presentation/widgets/timer_widget.dart';
import '../../core/utils/hive_service.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class TodoDetailScreen extends StatefulWidget {
  final TodoModel todoModel;
  final int index;
  const TodoDetailScreen(
      {super.key, required this.todoModel, required this.index});

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final Box<TodoModel> todoBox = HiveService().getTodoBox();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Column(
        children: [
          BlocBuilder<TodoBloc,TodoState>(builder: (context, state) {
            if(state is TodosLoadedState){
              final todo=todoBox.values.toList()[widget.index];
              return  Column(children: [
                ListTile(
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        todo.status.name.toUpperCase(),
                        style: TextStyle(
                            color: todo.status.getColor(), fontSize: 22),
                      )
                    ],
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(todo.description),
                ),
                TimerWidget(duration: todo.timer, onChanged: (value) {
                  context.read<TodoBloc>().add(UpdateTodoStatusEvent(
                      widget.index, TodoStatus.InProgress,value.toMinutes()),);
                  print(value);

                }, onTimerCompleted: () {
                  print('timer completed');

                },),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('Done'),
                      onPressed: () {
                        context
                            .read<TodoBloc>()
                            .add(UpdateTodoStatusEvent(widget.index, TodoStatus.Done,todo.timer));
                      },
                    ),
                    // ElevatedButton(
                    //   child: Text('Pause'),
                    //   onPressed: () {
                    //     if (widget.todoModel.status == TodoStatus.InProgress) {
                    //       context.read<TodoBloc>().add(PauseTimerEvent(widget.index));
                    //     } else {
                    //       context
                    //           .read<TodoBloc>()
                    //           .add(ResumeTimerEvent(widget.index));
                    //     }
                    //   },
                    // ),
                    // ElevatedButton(
                    //   child: Text('Cancel'),
                    //   onPressed: () {
                    //     context.read<TodoBloc>().add(UpdateTodoStatusEvent(
                    //         widget.index!, TodoStatus.InProgress,int.parse(widget.todoModel.timer.toString())));
                    //   },
                    // ),
                  ],
                )
              ],
              );
            }
            return Text('error');
          },),
          const SizedBox(
            height: 30,
          ),

        ],
      ),
    );
  }
}

String _formatTime(int timer) {
  final minutes = timer ~/ 60;
  final seconds = timer % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'; // Format as MM:SS
}
