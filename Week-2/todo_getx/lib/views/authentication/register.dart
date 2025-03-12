import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/authentication.dart';

class RegisterView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AnthController authController = Get.put(AnthController());

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('สมัครสมาชิก')),
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
            SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'ยืนยันรหัสผ่าน'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!GetUtils.isEmail(emailController.text)) {
                  Get.snackbar("ข้อผิดพลาด", "รูปแบบอีเมลไม่ถูกต้อง");
                  return;
                }

                if (passwordController.text.length < 6) {
                  Get.snackbar(
                    "ข้อผิดพลาด",
                    "รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัวอักษร",
                  );
                  return;
                }

                if (passwordController.text != confirmPasswordController.text) {
                  Get.snackbar(
                    "ข้อผิดพลาด",
                    "รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน",
                  );
                  return;
                }

                authController.register(
                  emailController.text,
                  passwordController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text('สมัคร'),
            ),
          ],
        ),
      ),
    );
  }
}
