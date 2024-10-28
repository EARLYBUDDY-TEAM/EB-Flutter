import 'package:flutter/material.dart';
import 'sources/findroute_example.dart';
import 'package:eb_env/eb_env.dart';

void main() async {
  await prepareENV(dev: true);
  runApp(const FindRouteExample());
}
