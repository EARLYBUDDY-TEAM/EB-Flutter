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
  String makeArrival1(int? arrivalSec1) {
    if (arrivalSec1 == null) {
      return "-분";
    }

    final minute = arrivalSec1 ~/ 60;
    return EBTime.intToHourMinuteString(minute);
  }

  String makeArrival2(int? arrivalSec2) {
    if (arrivalSec2 == null) {
      return "-분";
    }

    final minute = arrivalSec2 ~/ 60;
    return EBTime.intToHourMinuteString(minute);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.streamRealTimeInfo,
      builder: (context, snapshot) {
        final arrival1 = makeArrival1(snapshot.data?.arrivalSec1);
        final arrival2 = makeArrival2(snapshot.data?.arrivalSec2);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  "$arrival1 전",
                  style: const TextStyle(
                    fontFamily: FontFamily.gmarketSansBold,
                    fontSize: 38,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  '다음 배차까지 $arrival2전',
                  style: const TextStyle(
                    fontFamily: FontFamily.nanumSquareRegular,
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 10),
                _ReloadTransportInfoButton(),
              ],
            ),
          ],
        );
      },
    );
  }
}
