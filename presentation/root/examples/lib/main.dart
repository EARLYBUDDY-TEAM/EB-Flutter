import 'package:eb_root/eb_root.dart';
import 'package:flutter/material.dart';
import 'sources/root_example.dart';

void main() async {
  await runAppRootExample();
}

Future<void> runAppRootExample() async {
  await prepareApp(dev: true);
  final rootExample = RootExample();
  runApp(rootExample);
  await rootExample.init();
}
