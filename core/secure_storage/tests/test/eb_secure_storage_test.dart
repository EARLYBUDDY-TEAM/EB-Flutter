import 'package:flutter_test/flutter_test.dart';
import 'package:eb_secure_storage/eb_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  late SecureStorage storage;

  setUpAll(() {
    FlutterSecureStorage.setMockInitialValues({});
    storage = SecureStorage();
  });

  tearDownAll(() async {
    await storage.storage.deleteAll();
  });

  group("SecureStorage Test", () {
    test('read & write', () async {
      // given
      const String key = "test_key";
      const String value = "test_value";
      await storage.write(key: key, value: value);

      // when, then
      try {
        final fetched = await storage.read(key: key);
        expect(fetched, value);
      } catch (error) {
        rethrow;
      }
    });

    test('delete', () async {
      // given
      const String key = "test_key";
      const String value = "test_value";
      await storage.write(key: key, value: value);

      // when, then
      try {
        await storage.delete(key: key);
      } catch (error) {
        rethrow;
      }
    });
  });
}
