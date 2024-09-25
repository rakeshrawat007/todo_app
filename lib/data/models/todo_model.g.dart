import 'package:hive/hive.dart';
import 'package:todo_assesment/data/models/todo_model.dart';

import '../../presentation/bloc/todo_state.dart';

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 0;

  @override
  TodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // Correctly pass the status by using the index stored in Hive
    return TodoModel(
      title: fields[0] as String,
      description: fields[1] as String,
      timer: fields[2] as int,
      status: TodoStatus.values[fields[3] as int],  // Convert statusIndex back to enum
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(4)  // This indicates the number of fields
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.timer)
      ..writeByte(3)
      ..write(obj.status.index);  // Save the index of the status enum
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TodoModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}