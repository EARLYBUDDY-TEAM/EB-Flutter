part of '../eb_secure_storage.dart';

final class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future<String> read({
    required SecureStorageKey key,
  }) async {
    try {
      String? value = await storage.read(key: key.name);
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
    required SecureStorageKey key,
  }) async {
    try {
      await storage.delete(key: key.name);
    } catch (e) {
      log(e.toString());
      throw SecureStorageError.delete;
    }
  }

  Future<void> write({
    required SecureStorageKey key,
    required String value,
  }) async {
    try {
      await storage.write(key: key.name, value: value);
    } catch (e) {
      log(e.toString());
      throw SecureStorageError.write;
    }
  }
}
