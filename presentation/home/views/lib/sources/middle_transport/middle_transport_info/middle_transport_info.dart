part of '../../../eb_home.dart';

final class MiddleTransportInfo extends StatelessWidget {
  final EBSubPath subPath;
  final Stream<RealTimeInfo> stream;

  const MiddleTransportInfo({
    super.key,
    required this.subPath,
    required this.stream,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LeftDispatchColumn(subPath: subPath),
        _RightDisPatchColumn(stream: stream),
      ],
    );
  }
}
