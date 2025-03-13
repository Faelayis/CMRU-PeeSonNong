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

    ever(authController.user, (_) async {
      uid.value = authController.user.value?.uid ?? '';

      if (uid.value.isNotEmpty) {
        await loadTodos();
      } else {
        todoList.clear();
      }
    });

    if (uid.value.isNotEmpty) {
      loadTodos();
    }
  }

  Future<void> loadTodos() async {
    var userDbMatch = uid.value;
    var storedTodoList = await storageService.readData('todo', userDbMatch);

    if (storedTodoList.exists) {
      List<dynamic> todosJson =
          (storedTodoList.data() as Map<String, dynamic>)['todo'];
      todoList.value =
          todosJson.map((json) => TodoModel.fromJson(json)).toList();
    }
  }

  void saveTodos() async {
    var userDbMatch = uid.value;

    List<Map<String, dynamic>> todos =
        todoList.map((todo) => todo.toJson()).toList();
    await storageService.saveData('todo', userDbMatch, {'todo': todos});
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
