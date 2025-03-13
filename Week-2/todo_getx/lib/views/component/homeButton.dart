import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/authentication.dart';
import 'package:todo_getx/controllers/todo/controller.dart';
import 'package:todo_getx/views/todo/add.dart';
import 'package:todo_getx/views/authentication/login.dart';
import 'package:todo_getx/views/authentication/register.dart';

class HomeButton extends StatelessWidget {
  final TodoController todoController;
  final AnthController authController = Get.put(AnthController());

  HomeButton({super.key, required this.todoController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildFloatingActionButton(
                  onPressed: () => Get.to(() => AddTodoView()),
                  icon: Icons.add,
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
                        _buildFloatingActionButton(
                          onPressed: todoController.clearAll,
                          icon: Icons.clear_all,
                          backgroundColor: Colors.redAccent[100],
                        ),
                      if (hasCompletedTodos)
                        _buildFloatingActionButton(
                          onPressed: todoController.clearCompleted,
                          icon: Icons.clear,
                          backgroundColor: Colors.redAccent[100],
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  bool isUserLoggedIn = authController.user.value?.uid != null;
                  bool showAuthButtons = authController.showAuthButtons.value;

                  return Column(
                    children: [
                      if (showAuthButtons) ...[
                        if (!isUserLoggedIn)
                          _buildFloatingActionButton(
                            onPressed: () => Get.to(() => RegisterView()),
                            icon: Icons.login,
                          ),
                        if (!isUserLoggedIn) SizedBox(height: 10),
                        _buildFloatingActionButton(
                          onPressed: () {
                            if (!isUserLoggedIn) {
                              Get.to(() => LoginView());
                            } else {
                              authController.logout();
                            }
                          },
                          icon: isUserLoggedIn ? Icons.logout : Icons.person,
                          foregroundColor:
                              isUserLoggedIn ? Colors.red : Colors.black,
                        ),
                        SizedBox(height: 10),
                      ],
                      _buildFloatingActionButton(
                        onPressed: () {
                          authController.showAuthButtons.value =
                              !showAuthButtons;
                        },
                        icon: showAuthButtons ? Icons.close : Icons.menu,
                        foregroundColor: showAuthButtons ? Colors.red : null,
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: null,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      child: Icon(icon),
    );
  }
}
