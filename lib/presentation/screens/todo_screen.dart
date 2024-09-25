import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_assesment/core/utils/extenstion/extenstion.dart';
import 'package:todo_assesment/presentation/bloc/todo_event.dart';
import 'package:todo_assesment/presentation/bloc/todo_state.dart';
import 'package:todo_assesment/presentation/screens/todo_detail_screen.dart';
import 'package:todo_assesment/presentation/screens/todo_form.dart';
import '../bloc/todo_bloc.dart';


class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          if (state is TodosLoadedState) {
            final todos = state.todos;
            if (todos.isEmpty) {
              return const Center(child: Text('No Todos Added'));
            } else {
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Slidable(
                    enabled: true,
                    key: const ValueKey(1), // Consider using a unique value for key
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            context.read<TodoBloc>().add(DeleteTodoEvent(index));
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return TodoDetailScreen(index:index,todoModel: todo);
                        }));
                      },
                      child: ListTile(
                        trailing: Column(children: [
                          Text("${todo.timer.toMinutesSeconds()} Minutes"),
                        Text(todo.status.name,style: TextStyle(fontSize: 15,color: todo.status.getColor()),)],),
                        title: Text(todo.title),
                        subtitle: Text(todo.description),
                        leading: InkWell(
                          child: const Icon(Icons.edit_note_rounded),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return  TodoForm(isEditing: true,todoModel: todo,index: index,);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const TodoForm(isEditing: false,); // This should work now
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}