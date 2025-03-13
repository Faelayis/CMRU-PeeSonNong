import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_getx/views/home.dart';

class AnthController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var user = Rxn<User>();
  var showAuthButtons = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.value = firebaseAuth.currentUser;
    firebaseAuth.authStateChanges().listen((User? user) {
      this.user.value = user;
    });
  }

  Future<void> register(String email, String password) async {
    try {
      Get.closeAllSnackbars();

      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('การลงทะเบียนสำเร็จ', 'คุณได้ลงทะเบียนเรียบร้อยแล้ว');
      Get.offAll(HomeView());
    } catch (error) {
      Get.snackbar('การลงทะเบียนล้มเหลว', error.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      Get.closeAllSnackbars();

      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('เข้าสู่ระบบสำเร็จ', 'คุณได้เข้าสู่ระบบเรียบร้อยแล้ว');
      Get.offAll(HomeView());
    } catch (error) {
      Get.snackbar('การเข้าสู่ระบบล้มเหลว', error.toString());
    }
  }

  Future<void> logout() async {
    try {
      Get.closeAllSnackbars();

      await firebaseAuth.signOut();
      Get.snackbar('ออกจากระบบสำเร็จ', 'คุณได้ออกจากระบบเรียบร้อยแล้ว');
    } catch (error) {
      Get.snackbar('การออกจากระบบล้มเหลว', error.toString());
    }
  }

  Future<void> validateAndRegister(
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (!validateEmail(email) || !validatePassword(password, confirmPassword)) {
      return;
    }
    await register(email, password);
  }

  Future<void> validateAndLogin(String email, String password) async {
    if (!validateEmail(email) || password.isEmpty) {
      Get.snackbar("ข้อผิดพลาด", "กรุณากรอกรหัสผ่าน");
      return;
    }
    await login(email, password);
  }

  bool validateEmail(String email) {
    if (!GetUtils.isEmail(email)) {
      Get.snackbar("ข้อผิดพลาด", "รูปแบบอีเมลไม่ถูกต้อง");
      return false;
    }
    return true;
  }

  bool validatePassword(String password, [String confirmPassword = '']) {
    if (password.length < 6) {
      Get.snackbar("ข้อผิดพลาด", "รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัวอักษร");
      return false;
    }
    if (confirmPassword.isNotEmpty && password != confirmPassword) {
      Get.snackbar("ข้อผิดพลาด", "รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน");
      return false;
    }
    return true;
  }
}
