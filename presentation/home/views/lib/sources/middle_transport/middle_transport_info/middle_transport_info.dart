part of '../../../eb_home.dart';

final class MiddleTransportInfo extends StatelessWidget {
  final EBSubPath subPath;
  final Stream<RealTimeInfo?> streamRealTimeInfo;

  const MiddleTransportInfo({
    super.key,
    required this.subPath,
    required this.streamRealTimeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LeftDispatchColumn(subPath: subPath),
        _RightDisPatchColumn(streamRealTimeInfo: streamRealTimeInfo),
      ],
    );
  }
}
