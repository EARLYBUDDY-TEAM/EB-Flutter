import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // Create storage
// final storage = new FlutterSecureStorage();

// // Read value
// String value = await storage.read(key: key);

// // Read all values
// Map<String, String> allValues = await storage.readAll();

// // Delete value
// await storage.delete(key: key);

// // Delete all
// await storage.deleteAll();

// // Write value
// await storage.write(key: key, value: value);

final class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future<String?> read(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }
}
