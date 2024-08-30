import 'package:flutter/material.dart';
import 'sources/root_example.dart';

void main() async {
  await runAppRootExample();
}

Future<void> runAppRootExample() async {
  final rootExample = RootExample();
  runApp(rootExample);
  await rootExample.init();
}
