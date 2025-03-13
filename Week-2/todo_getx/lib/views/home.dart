import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/todo/controller.dart';
import 'package:todo_getx/models/todo/model.dart';
import 'package:todo_getx/views/component/homeButton.dart';

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
        if (todoController.todoList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
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
        }
      }),
      floatingActionButton: HomeButton(todoController: todoController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
