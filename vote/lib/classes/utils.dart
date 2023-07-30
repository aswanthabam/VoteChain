import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Utils {
  static final FlutterSecureStorage storage = new FlutterSecureStorage();
  static bool secureSave({required String key, required String value}) {
    try {
      storage.write(key: key, value: value);
      return true;
    } catch (err) {
      return false;
    }
  }
}
