part of 'home_example.dart';

EBSubPath get mockTransportSubPath {
  final path = EBPath.mockDongToGwang();

  EBSubPath? subPath;
  for (var curSubPath in path.ebSubPathList) {
    if (curSubPath.type == 2) {
      subPath = curSubPath;
      break;
    }
  }
  subPath ??= EBSubPath.mockBus();

  return subPath;

  // final newSubPath = subPath.copyWith(transports: []);

  // return newSubPath;
}
