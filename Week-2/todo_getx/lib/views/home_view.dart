import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/todo/controller.dart';
import 'package:todo_getx/models/todo/model.dart';
import 'package:todo_getx/views/add_todo_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: todoController.todoList.length,
          itemBuilder: (context, index) {
            TodoModel todo = todoController.todoList[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration:
                        todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                ),
                subtitle: todo.subtitle.isEmpty ? null : Text(todo.subtitle),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (bool? newValue) {
                    todoController.toggle(index);
                  },
                ),
                trailing: IconButton(
                  onPressed: () {
                    todoController.delete(index);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.to(() => AddTodoView());
            },
            heroTag: null,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          Obx(() {
            bool hasTodos = todoController.todoList.isNotEmpty;
            bool hasCompletedTodos = todoController.todoList.any(
              (todo) => todo.isDone,
            );
            bool hasIncompleteTodos = hasTodos && !hasCompletedTodos;

            return Column(
              children: [
                if (hasIncompleteTodos)
                  FloatingActionButton(
                    onPressed: () {
                      todoController.clearAll();
                    },
                    heroTag: null,
                    backgroundColor: Colors.redAccent[100],
                    child: Icon(Icons.clear_all),
                  ),
                if (hasCompletedTodos)
                  FloatingActionButton(
                    onPressed: () {
                      todoController.clearCompleted();
                    },
                    heroTag: null,
                    backgroundColor: Colors.redAccent[100],
                    child: Icon(Icons.clear),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
