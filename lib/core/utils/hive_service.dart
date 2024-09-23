import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/todo_model.dart';

class HiveService {
  Future<void> initHive() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(TodoModelAdapter());
    await Hive.openBox<TodoModel>('todos');
  }

  Box<TodoModel> getTodoBox() => Hive.box<TodoModel>('todos');
}