import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_getx/views/authentication/register.dart';
import 'package:todo_getx/views/authentication/login.dart';

class AnthController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var user = Rxn<User>();

  Future<void> register(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('การลงทะเบียนสำเร็จ', 'คุณได้ลงทะเบียนเรียบร้อยแล้ว');
      Get.offAll(RegisterView());
    } catch (error) {
      Get.snackbar('การลงทะเบียนล้มเหลว', error.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('เข้าสู่ระบบสำเร็จ', 'คุณได้เข้าสู่ระบบเรียบร้อยแล้ว');
      Get.offAll(LoginView());
    } catch (error) {
      Get.snackbar('การเข้าสู่ระบบล้มเหลว', error.toString());
    }
  }
}
