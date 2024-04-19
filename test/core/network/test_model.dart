import 'dart:convert';

final class TestModel {
  final int id;
  final String name;
  final String address;

  TestModel({
    required this.id,
    required this.name,
    required this.address,
  });

  static TestModel fromJson(Map<String, dynamic> jsonData) {
    return TestModel(
      id: jsonData['id'],
      name: jsonData['name'],
      address: jsonData['address'],
    );
  }

  static dynamic jsonData() {
    String jsonString = '''
{
  "id": 1,
  "name": "lorem ipsum",
  "address": "dolor set amet"
}
''';
    return jsonString;
  }
}
