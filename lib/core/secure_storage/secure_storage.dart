import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future<String?> read({
    required String key,
  }) async {
    String? value = await storage.read(key: key);
    return value;
  }

  Future<void> delete({
    required String key,
  }) async {
    await storage.delete(key: key);
  }

  Future<void> write({
    required String key,
    required String value,
  }) async {
    await storage.write(key: key, value: value);
  }
}
