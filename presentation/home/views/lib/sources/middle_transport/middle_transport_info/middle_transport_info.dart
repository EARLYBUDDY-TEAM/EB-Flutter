part of '../../../eb_home.dart';

final class MiddleTransportInfo extends StatelessWidget {
  final Transport? selectedTransport;
  final EBSubPath trasnportSubPath;
  final Stream<RealTimeInfo?> streamRealTimeInfo;

  const MiddleTransportInfo({
    super.key,
    required this.selectedTransport,
    required this.trasnportSubPath,
    required this.streamRealTimeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LeftDispatchColumn(
          transportSubPath: trasnportSubPath,
          selectedTransport: selectedTransport,
        ),
        _RightDisPatchColumn(streamRealTimeInfo: streamRealTimeInfo),
      ],
    );
  }
}
