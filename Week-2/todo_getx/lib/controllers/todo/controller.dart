import 'package:get/get.dart';
import 'package:todo_getx/controllers/authentication.dart';
import 'package:todo_getx/models/todo/model.dart';
import 'package:todo_getx/services/storage.dart';

class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs;
  var uid = ''.obs;

  final StorageService storageService = StorageService();
  final AnthController authController = Get.put(AnthController());

  @override
  void onInit() {
    super.onInit();

    uid.value = authController.user.value?.uid ?? '';
    if (uid.isNotEmpty) {
      loadTodos();
    }

    ever(authController.user, (_) async {
      uid.value = authController.user.value?.uid ?? '';
      if (uid.isNotEmpty) {
        await loadTodos();
      } else {
        todoList.clear();
      }
    });
  }

  Future<void> loadTodos() async {
    if (uid.isEmpty) return;

    var storedTodoList = await storageService.readData('todo', uid.value);
    if (storedTodoList.exists) {
      var todosJson =
          (storedTodoList.data() as Map<String, dynamic>)['todo']
              as List<dynamic>;
      todoList.value =
          todosJson.map((json) => TodoModel.fromJson(json)).toList();
    }
  }

  Future<void> saveTodos() async {
    if (uid.isEmpty) return;

    var todos = todoList.map((todo) => todo.toJson()).toList();
    await storageService.saveData('todo', uid.value, {'todo': todos});
  }

  void add(String title, String subtitle) {
    todoList.add(
      TodoModel(
        title: title,
        subtitle: subtitle,
        isDone: false,
        uid: uid.value,
      ),
    );
    saveTodos();
  }

  void updateTodo(int index, String newTitle, String newSubtitle) {
    var todo = todoList[index];
    todo.title = newTitle;
    todo.subtitle = newSubtitle;
    todoList.refresh();
    saveTodos();
  }

  void toggle(int index) {
    var todo = todoList[index];
    todo.isDone = !todo.isDone;
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
