import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/todo/controller.dart';
import 'package:todo_getx/views/home.dart';

class TodoFormPage extends StatelessWidget {
  final int? index;
  final TodoController todoController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

  TodoFormPage({super.key, this.index}) {
    if (index != null) {
      final todo = todoController.todoList[index!];
      titleController.text = todo.title;
      subtitleController.text = todo.subtitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = index != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'แก้ไขรายการ' : 'เพิ่มรายการ'),
        backgroundColor: isEditing ? null : Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('ชื่อรายการ'),
              const SizedBox(height: 10),
              _buildTextField(
                controller: titleController,
                hintText: 'ชื่อรายการ',
              ),
              const SizedBox(height: 20),
              _buildLabel('รายละเอียด'),
              const SizedBox(height: 10),
              _buildTextField(
                controller: subtitleController,
                hintText: 'รายละเอียด',
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () => _handleSave(isEditing),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('บันทึก'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
      maxLines: maxLines,
    );
  }

  void _handleSave(bool isEditing) {
    final title = titleController.text.trim();
    final subtitle = subtitleController.text.trim();

    if (title.isEmpty || subtitle.isEmpty) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'กรุณากรอกข้อมูลให้ครบถ้วน',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (isEditing) {
      todoController.updateTodo(index!, title, subtitle);
    } else {
      todoController.add(title, subtitle);
    }

    Get.offAll(() => HomeView());
  }
}
