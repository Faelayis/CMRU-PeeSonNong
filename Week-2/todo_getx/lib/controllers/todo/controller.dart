import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_getx/models/todo/model.dart';

class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs;
  final GetStorage _box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    List<dynamic> storedTodos = _box.read<List<dynamic>>('todos') ?? [];
    todoList.value =
        storedTodos.map((json) => TodoModel.fromJson(json)).toList();
  }

  void saveTodos() {
    List<Map<String, dynamic>> todos =
        todoList.map((todo) => todo.toJson()).toList();
    _box.write('todos', todos);
  }

  void add(String title, String subtitle) {
    todoList.add(TodoModel(title, subtitle, false));
    saveTodos();
  }

  void toggle(int index) {
    todoList[index].isDone = !todoList[index].isDone;
    todoList.refresh();
    saveTodos();
  }

  void delete(int index) {
    todoList.removeAt(index);
    saveTodos();
  }

  void clearAll() {
    todoList.clear();
    saveTodos();
  }

  void clearCompleted() {
    todoList.removeWhere((todo) => todo.isDone);
    saveTodos();
  }
}
