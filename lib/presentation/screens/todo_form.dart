import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/todo_model.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';

class TodoForm extends StatefulWidget {
  final bool isEditing;
  final int? index;
  final TodoModel? todoModel;

  const TodoForm({super.key, this.todoModel, required this.isEditing, this.index});

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setValues();
  }

  void setValues() {
    if (widget.todoModel != null) {
      _titleController.text = widget.todoModel!.title;
      _descriptionController.text = widget.todoModel!.description;
      _timeController.text = widget.todoModel!.timer.toString();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time in Minutes'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.isEditing ? 'Update' : 'Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final todo = TodoModel(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      timer: int.parse(_timeController.text),
                      isCompleted: false,
                      isRunning: false,
                    );
                    if (widget.isEditing) {
                      context.read<TodoBloc>().add(EditTodoEvent(widget.index!, todo));
                    } else {
                      context.read<TodoBloc>().add(AddTodoEvent(todo));
                    }
                    Navigator.pop(context);
                  }
                },
              ),
              ElevatedButton(
                child: Text('Play'),
                onPressed: () {

                },
              ),
              ElevatedButton(
                child: Text('Pause'),
                onPressed: () {

                },
              ),
              ElevatedButton(
                child: Text('Stop'),
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}