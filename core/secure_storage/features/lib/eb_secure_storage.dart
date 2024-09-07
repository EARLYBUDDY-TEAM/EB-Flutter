import 'dart:developer';
import 'package:eb_secure_storage_interface/eb_secure_storage_interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future<String> read({
    required String key,
  }) async {
    try {
      String? value = await storage.read(key: key);
      if (value == null) {
        throw SecureStorageError.read;
      }
      return value;
    } catch (e) {
      log(e.toString());
      throw SecureStorageError.read;
    }
  }

  Future<void> delete({
    required String key,
  }) async {
    try {
      await storage.delete(key: key);
    } catch (e) {
      log(e.toString());
      throw SecureStorageError.delete;
    }
  }

  Future<void> write({
    required String key,
    required String value,
  }) async {
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      log(e.toString());
      throw SecureStorageError.write;
    }
  }
}
