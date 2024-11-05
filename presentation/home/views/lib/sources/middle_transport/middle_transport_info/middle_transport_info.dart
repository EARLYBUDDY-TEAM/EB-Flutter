part of '../../../eb_home.dart';

final class MiddleTransportInfo extends StatelessWidget {
  final EBSubPath trasnportSubPath;
  final Stream<RealTimeInfo?> streamRealTimeInfo;

  const MiddleTransportInfo({
    super.key,
    required this.trasnportSubPath,
    required this.streamRealTimeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LeftDispatchColumn(trasnportSubPath: trasnportSubPath),
        _RightDisPatchColumn(streamRealTimeInfo: streamRealTimeInfo),
      ],
    );
  }
}
