import 'package:eb_root/eb_root.dart';

import 'package:flutter/material.dart';
import 'sources/root_example.dart';

void main() async {
  await PrepareRoot.setup(dev: true);
  await PrepareRoot.checkFirstLaunch();
  final rootExample = RootExample();
  runApp(rootExample);
  // await rootExample.setAutoLogin();
}
