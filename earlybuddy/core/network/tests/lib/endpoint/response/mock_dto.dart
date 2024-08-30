final class MockDTO {
  final int id;
  final String name;
  final String address;

  MockDTO({
    required this.id,
    required this.name,
    required this.address,
  });

  static MockDTO fromJson(Map<String, dynamic> j) {
    return MockDTO(
      id: j['id'],
      name: j['name'],
      address: j['address'],
    );
  }

  static dynamic successJsonData() {
    String jsonString = '''
{
  "id": 1,
  "name": "lorem ipsum",
  "address": "dolor set amet"
}
''';
    return jsonString;
  }

  static dynamic failJsonData() {
    String jsonString = '''
{
  "id": 1,
  "fail1": "lorem ipsum",
  "fail2": "dolor set amet"
}
''';
    return jsonString;
  }
}
