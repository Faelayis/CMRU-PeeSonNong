import 'package:flutter/material.dart';
import 'package:todo_getx/controllers/todo/controller.dart';
import 'package:get/get.dart';

class AddTodoView extends StatelessWidget {
  AddTodoView({super.key});

  final TodoController todoController = Get.put(TodoController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มรายการ"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ชื่อรายการ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              Text(
                "รายละเอียด",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                maxLines: 3,
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty) return;
                    todoController.add(
                      titleController.text,
                      subtitleController.text,
                    );
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text("บันทึก"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
