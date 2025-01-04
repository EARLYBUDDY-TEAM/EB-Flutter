part of '../eb_model_helper.dart';

final _random = math.Random();

class EBRandom {
  static int nexInt({
    int min = 0,
    int max = 1000,
  }) {
    return min + _random.nextInt(max - min);
  }
}
