part of '../../../eb_home.dart';

final class _RightDisPatchColumn extends StatefulWidget {
  final Stream<RealTimeInfo?> streamRealTimeInfo;

  const _RightDisPatchColumn({
    super.key,
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
        final arrival1 = makeArrival1String(snapshot.data?.arrivalSec1);
        final arrival2 = makeArrival2String(snapshot.data?.arrivalSec2);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _arrival1Text(arrival1),
            const SizedBox(height: 5),
            _arrival2TextAndReloadButton(arrival2),
          ],
        );
      },
    );
  }
}

extension on _RightDisPatchColumnState {
  Widget _arrival2TextAndReloadButton(String arrival2) {
    return Row(
      children: [
        _arrival2Text(arrival2),
        const SizedBox(width: 5),
        _ReloadTransportInfoButton(),
      ],
    );
  }
}

extension on _RightDisPatchColumnState {
  String makeArrival1String(int? arrivalSec1) {
    if (arrivalSec1 == null) {
      return "-분";
    }

    final minute = arrivalSec1 ~/ 60;
    return EBTime.intToHourMinuteString(minute);
  }

  Widget _arrival1Text(String arrival1) {
    return Row(
      children: [
        Text(
          "$arrival1 전",
          style: const TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 35,
          ),
        ),
        const SizedBox(width: 3),
      ],
    );
  }
}

extension on _RightDisPatchColumnState {
  String makeArrival2String(int? arrivalSec2) {
    if (arrivalSec2 == null) {
      return "-분";
    }

    final minute = arrivalSec2 ~/ 60;
    return EBTime.intToHourMinuteString(minute);
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
