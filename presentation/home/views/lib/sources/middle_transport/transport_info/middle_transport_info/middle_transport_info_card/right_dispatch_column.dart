part of '../../../../../eb_home.dart';

final class _RightDisPatchColumn extends StatefulWidget {
  final int index;
  final Stream<RealTimeInfo?>? streamRealTimeInfo;

  const _RightDisPatchColumn({
    super.key,
    required this.index,
    required this.streamRealTimeInfo,
  });

  @override
  State<StatefulWidget> createState() => _RightDisPatchColumnState();
}

final class _RightDisPatchColumnState extends State<_RightDisPatchColumn> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.streamRealTimeInfo,
      builder: (context, snapshot) {
        final arrivalSec1 = snapshot.data?.arrivalSec1;
        final arrivalSec2 = snapshot.data?.arrivalSec2;

        return _RightDisPatchColumnContent(
          index: widget.index,
          arrivalSec1: arrivalSec1,
          arrivalSec2: arrivalSec2,
        );
      },
    );
  }
}

final class _RightDisPatchColumnContent extends StatelessWidget {
  final int index;
  final int? arrivalSec1;
  final int? arrivalSec2;

  String convertArrivalIntToString(int? arrivalSec) {
    if (arrivalSec == null) {
      return "-분";
    }

    final minute = arrivalSec ~/ 60;
    return EBTime.intMinuteToString(minute);
  }

  const _RightDisPatchColumnContent({
    required this.index,
    required this.arrivalSec1,
    required this.arrivalSec2,
  });

  @override
  Widget build(BuildContext context) {
    final arrival1 = convertArrivalIntToString(arrivalSec1);
    final arrival2 = convertArrivalIntToString(arrivalSec2);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _arrival1Text(arrival1),
        const SizedBox(height: 5),
        _arrival2TextAndReloadButton(arrival2),
      ],
    );
  }

  Widget _arrival2TextAndReloadButton(String arrival2) {
    return Row(
      children: [
        _arrival2Text(arrival2),
        const SizedBox(width: 5),
        _ReloadTransportInfoCardButton(index: index),
      ],
    );
  }

  Widget _arrival1Text(String arrival1) {
    return Row(
      children: [
        Text(
          arrival1,
          style: const TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 40,
          ),
        ),
        const SizedBox(width: 3),
      ],
    );
  }

  Widget _arrival2Text(String arrival2) {
    return Text(
      '다음 배차까지 $arrival2전',
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: Colors.black87,
        fontSize: 12,
      ),
    );
  }
}
