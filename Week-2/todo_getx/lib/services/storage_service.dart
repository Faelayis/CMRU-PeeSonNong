import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  Future<void> saveData(String key, dynamic value) async {
    await _box.write(key, value);
  }

  static Future<void> init() async {
    await GetStorage.init();
  }

  read(String s) {}
}

Future<void> write(String key, dynamic value) async {
  final GetStorage box = GetStorage();
  await box.write(key, value);
}
