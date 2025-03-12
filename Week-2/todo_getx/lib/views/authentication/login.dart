import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/authentication.dart';
import 'package:todo_getx/views/authentication/register.dart'; // Import the RegisterView

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AnthController authController = Get.put(AnthController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เข้าสู่ระบบ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'อีเมล'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'รหัสผ่าน'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!GetUtils.isEmail(emailController.text)) {
                  Get.snackbar("ข้อผิดพลาด", "รูปแบบอีเมลไม่ถูกต้อง");
                  return;
                }

                if (passwordController.text.isEmpty) {
                  Get.snackbar("ข้อผิดพลาด", "กรุณากรอกรหัสผ่าน");
                  return;
                }

                authController.login(
                  emailController.text,
                  passwordController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text('เข้าสู่ระบบ'),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.to(() => RegisterView());
            },
            heroTag: null,
            child: Icon(Icons.login),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
