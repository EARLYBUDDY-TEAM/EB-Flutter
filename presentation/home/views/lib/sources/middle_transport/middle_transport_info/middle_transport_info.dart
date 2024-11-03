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

  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       BlocBuilder<HomeBloc, HomeState>(
  //         buildWhen: (previous, current) {
  //           final preMiddleState = castOrNull<InfoMiddleTransportState>(
  //               previous.middleTransportInfoState);
  //           final curMiddleState = castOrNull<InfoMiddleTransportState>(
  //               current.middleTransportInfoState);

  //           if (curMiddleState == null) {
  //             return false;
  //           }

  //           if (preMiddleState == null) {
  //             return true;
  //           }

  //           return (preMiddleState.leftDisPatchState !=
  //                   curMiddleState.leftDisPatchState)
  //               ? true
  //               : false;
  //         },
  //         builder: (context, state) {
  //           final middleState =
  //               state.middleTransportInfoState as InfoMiddleTransportState;
  //           final subPath = middleState.leftDisPatchState.subPath;

  //           return _LeftDispatchColumn(subPath: subPath);
  //         },
  //       ),
  //       BlocBuilder<HomeBloc, HomeState>(
  //         buildWhen: (previous, current) {
  //           final preMiddleState = castOrNull<InfoMiddleTransportState>(
  //               previous.middleTransportInfoState);
  //           final curMiddleState = castOrNull<InfoMiddleTransportState>(
  //               current.middleTransportInfoState);

  //           if (curMiddleState == null) {
  //             return false;
  //           }

  //           if (preMiddleState == null) {
  //             return true;
  //           }

  //           return (preMiddleState.rightDisPatchState !=
  //                   curMiddleState.rightDisPatchState)
  //               ? true
  //               : false;
  //         },
  //         builder: (context, state) {
  //           final middleState =
  //               state.middleTransportInfoState as InfoMiddleTransportState;
  //           final realTimeInfo = middleState.rightDisPatchState.realTimeInfo;

  //           return _RightDisPatchColumn(realTimeInfo: realTimeInfo);
  //         },
  //       ),
  //     ],
  //   );
  // }
}
