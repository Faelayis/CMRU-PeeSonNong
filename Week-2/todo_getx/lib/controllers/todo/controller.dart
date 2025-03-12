import 'package:get/get.dart';
import 'package:todo_getx/models/todo/model.dart';
import 'package:todo_getx/services/storage.dart';

class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs;
  var dbmatch = 'todoList';

  final StorageService storageService = StorageService();

  @override
  void onInit() async {
    super.onInit();

    var storedTodos = await storageService.readData('todo', dbmatch);
    if (storedTodos.exists) {
      List<dynamic> todosJson =
          (storedTodos.data() as Map<String, dynamic>)['todo'];
      todoList.value =
          todosJson.map((json) => TodoModel.fromJson(json)).toList();
    }
  }

  void saveTodos() async {
    List<Map<String, dynamic>> todos =
        todoList.map((todo) => todo.toJson()).toList();
    await storageService.saveData('todo', dbmatch, {'todo': todos});
  }

  void add(String title, String subtitle) {
    todoList.add(TodoModel(title: title, subtitle: subtitle, isDone: false));
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
